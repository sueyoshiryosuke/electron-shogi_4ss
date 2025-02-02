<template>
  <div>
    <BoardView
      :piece-image-type="appSetting.pieceImage"
      :board-image-type="appSetting.boardImage"
      :board-label-type="appSetting.boardLabelType"
      :max-size="maxSize"
      :position="store.record.position"
      :last-move="lastMove"
      :flip="appSetting.boardFlipping"
      :allow-move="store.isMovableByUser"
      :allow-edit="store.appState === AppState.POSITION_EDITING"
      :black-player-name="blackPlayerName"
      :white-player-name="whitePlayerName"
      :black-player-time="clock?.black.time"
      :black-player-byoyomi="clock?.black.byoyomi"
      :white-player-time="clock?.white.time"
      :white-player-byoyomi="clock?.white.byoyomi"
      :next-move-label="t.nextTurn"
      @resize="onResize"
      @move="onMove"
      @edit="onEdit"
    >
      <template #right-control>
        <div ref="rightControl" class="control top">
          <button
            v-if="controlStates.game"
            class="control-item"
            @click="onGame"
          >
            <ButtonIcon class="icon" :icon="Icon.GAME" />
            <span>{{ t.game }}</span>
          </button>
          <button
            v-if="controlStates.showGameResults"
            class="control-item"
            @click="onShowGameResults"
          >
            <ButtonIcon class="icon" :icon="Icon.SCORE" />
            <span>{{ t.displayGameResults }}</span>
          </button>
          <button
            v-if="controlStates.stop"
            class="control-item"
            data-hotkey="Escape"
            @click="onStop"
          >
            <ButtonIcon class="icon" :icon="Icon.STOP" />
            <span>{{ t.stopGame }}</span>
          </button>
          <button v-if="controlStates.win" class="control-item" @click="onWin">
            <ButtonIcon class="icon" :icon="Icon.CALL" />
            <span>{{ t.declareWinning }}</span>
          </button>
          <button
            v-if="controlStates.resign"
            class="control-item"
            @click="onResign"
          >
            <ButtonIcon class="icon" :icon="Icon.RESIGN" />
            <span>{{ t.resign }}</span>
          </button>
          <button
            v-if="controlStates.research"
            class="control-item"
            data-hotkey="Control+r"
            @click="onResearch"
          >
            <ButtonIcon class="icon" :icon="Icon.RESEARCH" />
            <span>{{ t.research }}</span>
          </button>
          <button
            v-if="controlStates.endResearch"
            class="control-item"
            data-hotkey="Escape"
            @click="onEndResearch"
          >
            <ButtonIcon class="icon" :icon="Icon.END" />
            <span>{{ t.endResearch }}</span>
          </button>
          <button
            v-if="controlStates.analysis"
            class="control-item"
            data-hotkey="Control+a"
            @click="onAnalysis"
          >
            <ButtonIcon class="icon" :icon="Icon.ANALYSIS" />
            <span>{{ t.analysis }}</span>
          </button>
          <button
            v-if="controlStates.endAnalysis"
            class="control-item"
            data-hotkey="Escape"
            @click="onEndAnalysis"
          >
            <ButtonIcon class="icon" :icon="Icon.STOP" />
            <span>{{ t.stopAnalysis }}</span>
          </button>
          <button
            v-if="controlStates.startEditPosition"
            class="control-item"
            @click="onStartEditPosition"
          >
            <ButtonIcon class="icon" :icon="Icon.EDIT" />
            <span>{{ t.setupPosition }}</span>
          </button>
          <button
            v-if="controlStates.endEditPosition"
            class="control-item"
            @click="onEndEditPosition"
          >
            <ButtonIcon class="icon" :icon="Icon.CHECK" />
            <span>{{ t.completePositionSetup }}</span>
          </button>
          <button
            v-if="controlStates.initPosition"
            class="control-item"
            @click="onChangeTurn"
          >
            <ButtonIcon class="icon" :icon="Icon.SWAP" />
            <span>{{ t.changeTurn }}</span>
          </button>
          <button
            v-if="controlStates.initPosition"
            class="control-item"
            @click="onInitPosition"
          >
            <span>{{ t.initializePosition }}</span>
          </button>
        </div>
      </template>
      <template #left-control>
        <div ref="leftControl" class="control bottom">
          <button
            class="control-item"
            data-hotkey="Control+,"
            @click="onOpenAppSettings"
          >
            <ButtonIcon class="icon" :icon="Icon.SETTINGS" />
            <span>{{ t.appSettings }}</span>
          </button>
          <button
            class="control-item"
            data-hotkey="Control+."
            :disabled="!controlStates.engineSettings"
            @click="onOpenEngineSettings"
          >
            <ButtonIcon class="icon" :icon="Icon.ENGINE_SETTINGS" />
            <span>{{ t.engineSettings }}</span>
          </button>
          <button class="control-item" data-hotkey="Control+t" @click="onFlip">
            <ButtonIcon class="icon" :icon="Icon.FLIP" />
            <span>{{ t.flipBoard }}</span>
          </button>
          <button class="control-item" @click="onFileAction">
            <ButtonIcon class="icon" :icon="Icon.FILE" />
            <span>{{ t.file }}</span>
          </button>
          <button
            class="control-item"
            data-hotkey="Control+d"
            :disabled="!controlStates.removeCurrentMove"
            @click="onRemoveCurrentMove"
          >
            <ButtonIcon class="icon" :icon="Icon.DELETE" />
            <span>{{ t.deleteMove }}</span>
          </button>
        </div>
      </template>
    </BoardView>
    <GameMenu v-if="isGameMenuVisible" @close="isGameMenuVisible = false" />
    <FileMenu v-if="isFileMenuVisible" @close="isFileMenuVisible = false" />
    <InitialPositionMenu
      v-if="isInitialPositionMenuVisible"
      @close="isInitialPositionMenuVisible = false"
    />
  </div>
</template>

<script lang="ts">
import { t } from "@/common/i18n";
import {
  computed,
  defineComponent,
  onUpdated,
  onBeforeUpdate,
  ref,
  onMounted,
  onBeforeUnmount,
} from "vue";
import BoardView from "@/renderer/view/primitive/BoardView.vue";
import { Move, PositionChange, RecordMetadataKey } from "@/common/shogi";
import { RectSize } from "@/common/graphics.js";
import { useStore } from "@/renderer/store";
import ButtonIcon from "@/renderer/view/primitive/ButtonIcon.vue";
import { AppState } from "@/common/control/state.js";
import { humanPlayer } from "@/renderer/players/human";
import { Icon } from "@/renderer/assets/icons";
import GameMenu from "@/renderer/view/menu/GameMenu.vue";
import FileMenu from "@/renderer/view/menu/FileMenu.vue";
import InitialPositionMenu from "@/renderer/view/menu/InitialPositionMenu.vue";
import { CSAGameState } from "@/renderer/store/csa";
import {
  installHotKeyForMainWindow,
  uninstallHotKeyForMainWindow,
} from "@/renderer/keyboard/hotkey";
import { useAppSetting } from "@/renderer/store/setting";

export default defineComponent({
  name: "BoardPane",
  components: {
    BoardView,
    ButtonIcon,
    GameMenu,
    FileMenu,
    InitialPositionMenu,
  },
  props: {
    maxSize: {
      type: RectSize,
      required: true,
    },
  },
  emits: ["resize"],
  setup(_, context) {
    const store = useStore();
    const appSetting = useAppSetting();
    const rightControl = ref();
    const leftControl = ref();
    const isGameMenuVisible = ref(false);
    const isFileMenuVisible = ref(false);
    const isInitialPositionMenuVisible = ref(false);

    onMounted(() => {
      installHotKeyForMainWindow(rightControl.value);
      installHotKeyForMainWindow(leftControl.value);
    });

    onUpdated(() => {
      installHotKeyForMainWindow(rightControl.value);
      installHotKeyForMainWindow(leftControl.value);
    });

    onBeforeUpdate(() => {
      uninstallHotKeyForMainWindow(rightControl.value);
      uninstallHotKeyForMainWindow(leftControl.value);
    });

    onBeforeUnmount(() => {
      uninstallHotKeyForMainWindow(rightControl.value);
      uninstallHotKeyForMainWindow(leftControl.value);
    });

    const onResize = (size: RectSize) => {
      context.emit("resize", size);
    };

    const onMove = (move: Move) => {
      if (
        store.appState === AppState.GAME ||
        store.appState === AppState.CSA_GAME
      ) {
        humanPlayer.doMove(move);
      } else {
        store.doMove(move);
      }
    };

    const onEdit = (change: PositionChange) => {
      store.editPosition(change);
    };

    const onGame = () => {
      isGameMenuVisible.value = true;
    };

    const onShowGameResults = () => {
      store.showGameResults();
    };

    const onStop = () => {
      store.stopGame();
    };

    const onWin = () => {
      humanPlayer.win();
    };

    const onResign = () => {
      humanPlayer.resign();
    };

    const onResearch = () => {
      store.showResearchDialog();
    };

    const onEndResearch = () => {
      store.stopResearch();
    };

    const onAnalysis = () => {
      store.showAnalysisDialog();
    };

    const onEndAnalysis = () => {
      store.stopAnalysis();
    };

    const onStartEditPosition = () => {
      store.startPositionEditing();
    };

    const onEndEditPosition = () => {
      store.endPositionEditing();
    };

    const onInitPosition = () => {
      isInitialPositionMenuVisible.value = true;
    };

    const onChangeTurn = () => {
      store.changeTurn();
    };

    const onOpenAppSettings = () => {
      store.showAppSettingDialog();
    };

    const onOpenEngineSettings = () => {
      store.showUsiEngineManagementDialog();
    };

    const onFlip = () => {
      appSetting.flipBoard();
    };

    const onFileAction = () => {
      isFileMenuVisible.value = true;
    };

    const onRemoveCurrentMove = () => {
      store.removeCurrentMove();
    };

    const lastMove = computed(() => {
      const move = store.record.current.move;
      return move instanceof Move ? move : undefined;
    });

    const blackPlayerName = computed(() => {
      return (
        store.record.metadata.getStandardMetadata(
          RecordMetadataKey.BLACK_NAME
        ) || t.sente
      );
    });

    const whitePlayerName = computed(() => {
      return (
        store.record.metadata.getStandardMetadata(
          RecordMetadataKey.WHITE_NAME
        ) || t.gote
      );
    });

    const clock = computed(() => {
      if (
        store.appState === AppState.GAME ||
        store.csaGameState === CSAGameState.GAME
      ) {
        return {
          black: {
            time: store.blackTime,
            byoyomi: store.blackByoyomi,
          },
          white: {
            time: store.whiteTime,
            byoyomi: store.whiteByoyomi,
          },
        };
      }
      return undefined;
    });

    const controlStates = computed(() => {
      return {
        game: store.appState === AppState.NORMAL,
        showGameResults:
          store.appState === AppState.GAME && store.gameSetting.repeat >= 2,
        stop:
          store.appState === AppState.GAME ||
          store.appState === AppState.CSA_GAME,
        win: store.appState === AppState.CSA_GAME && store.isMovableByUser,
        resign:
          (store.appState === AppState.GAME ||
            store.appState === AppState.CSA_GAME) &&
          store.isMovableByUser,
        research: store.appState === AppState.NORMAL,
        endResearch: store.appState === AppState.RESEARCH,
        analysis: store.appState === AppState.NORMAL,
        endAnalysis: store.appState === AppState.ANALYSIS,
        startEditPosition: store.appState === AppState.NORMAL,
        endEditPosition: store.appState === AppState.POSITION_EDITING,
        initPosition: store.appState === AppState.POSITION_EDITING,
        removeCurrentMove:
          store.appState === AppState.NORMAL ||
          store.appState === AppState.RESEARCH,
        engineSettings: store.appState === AppState.NORMAL,
      };
    });

    return {
      t,
      store,
      rightControl,
      leftControl,
      isGameMenuVisible,
      isFileMenuVisible,
      isInitialPositionMenuVisible,
      appSetting,
      lastMove,
      blackPlayerName,
      whitePlayerName,
      clock,
      controlStates,
      onResize,
      onMove,
      onEdit,
      onGame,
      onShowGameResults,
      onStop,
      onWin,
      onResign,
      onResearch,
      onEndResearch,
      onAnalysis,
      onEndAnalysis,
      onStartEditPosition,
      onEndEditPosition,
      onInitPosition,
      onChangeTurn,
      onOpenAppSettings,
      onOpenEngineSettings,
      onFlip,
      onFileAction,
      onRemoveCurrentMove,
      Icon,
      AppState,
    };
  },
});
</script>

<style scoped>
.control {
  width: 100%;
  height: 100%;
}
.control.top {
  display: flex;
  flex-direction: column;
}
.control.bottom {
  display: flex;
  flex-direction: column-reverse;
}
.control .control-item {
  width: 100%;
  height: 19%;
  font-size: 100%;
  text-align: left;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: clip;
  line-height: 200%;
  padding: 0 5% 0 5%;
}
.control.top .control-item:not(:last-child) {
  margin-bottom: 1%;
}
.control.bottom .control-item:not(:last-child) {
  margin-top: 1%;
}
.control .control-item .icon {
  height: 68%;
  vertical-align: top;
}
</style>
