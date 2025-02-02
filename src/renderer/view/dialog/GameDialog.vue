<template>
  <div>
    <dialog ref="dialog">
      <div class="dialog-title">{{ t.game }}</div>
      <div class="dialog-form-area">
        <div class="players">
          <div class="player">
            <div class="top-label">{{ t.senteOrShitate }}</div>
            <PlayerSelector
              :player-uri="blackPlayerURI"
              :contains-human="true"
              :engine-settings="engineSettings"
              :display-ponder-state="true"
              :display-thread-state="true"
              :display-multi-pv-state="true"
              @update-engine-setting="onUpdatePlayerSetting"
              @select-player="onSelectBlackPlayer"
            />
          </div>
          <div class="player">
            <div class="top-label">{{ t.goteOrUwate }}</div>
            <PlayerSelector
              v-if="whitePlayerURI"
              :player-uri="whitePlayerURI"
              :contains-human="true"
              :engine-settings="engineSettings"
              :display-ponder-state="true"
              :display-thread-state="true"
              :display-multi-pv-state="true"
              @update-engine-setting="onUpdatePlayerSetting"
              @select-player="onSelectWhitePlayer"
            />
          </div>
        </div>
        <div class="players-control">
          <button @click="onSwapColor">
            <ButtonIcon class="icon" :icon="Icon.SWAP_H" />
            <span>{{ t.swapSenteGote }}</span>
          </button>
        </div>
      </div>
      <div class="dialog-form-areas-h">
        <div class="dialog-form-area time-limit">
          <div class="top-label">{{ t.time }}</div>
          <div class="dialog-form-item">
            <!-- TODO: Translate -->
            <div class="dialog-form-item-label">持ち時間</div>
            <input
              ref="hours"
              class="time"
              type="number"
              min="0"
              max="99"
              step="1"
            />
            <div class="dialog-form-item-unit">{{ t.hoursSuffix }}</div>
            <input
              ref="minutes"
              class="time"
              type="number"
              min="0"
              max="59"
              step="1"
            />
            <div class="dialog-form-item-unit">{{ t.minutesSuffix }}</div>
          </div>
          <div class="dialog-form-item">
            <!-- TODO: Translate -->
            <div class="dialog-form-item-label">秒読み</div>
            <input
              ref="byoyomi"
              class="time"
              type="number"
              min="0"
              max="60"
              step="1"
            />
            <div class="dialog-form-item-unit">{{ t.secondsSuffix }}</div>
          </div>
          <div class="dialog-form-item">
            <!-- TODO: Translate -->
            <div class="dialog-form-item-label">増加</div>
            <input
              ref="increment"
              class="time"
              type="number"
              min="0"
              max="99"
              step="1"
            />
            <div class="dialog-form-item-unit">{{ t.secondsSuffix }}</div>
          </div>
          <div class="dialog-form-item">
            <input
              id="enable-engine-timeout"
              ref="enableEngineTimeout"
              type="checkbox"
            />
            <label for="enable-engine-timeout">{{
              t.enableEngineTimeout
            }}</label>
          </div>
        </div>
        <div class="dialog-form-area flags">
          <div class="top-label">{{ t.others }}</div>
          <div class="dialog-form-item">
            <div class="dialog-form-item-label">{{ t.startPosition }}</div>
            <select ref="startPosition">
              <option value="current">{{ t.currentPosition }}</option>
              <option value="standard">{{ t.nonHandicap }}</option>
              <option value="handicapLance">{{ t.lanceHandicap }}</option>
              <option value="handicapRightLance">
                {{ t.rightLanceHandicap }}
              </option>
              <option value="handicapBishop">{{ t.bishopHandicap }}</option>
              <option value="handicapRook">{{ t.rookHandicap }}</option>
              <option value="handicapRookLance">
                {{ t.rookLanceHandicap }}
              </option>
              <option value="handicap2Pieces">{{ t.twoPiecesHandicap }}</option>
              <option value="handicap4Pieces">
                {{ t.fourPiecesHandicap }}
              </option>
              <option value="handicap6Pieces">{{ t.sixPiecesHandicap }}</option>
              <option value="handicap8Pieces">
                {{ t.eightPiecesHandicap }}
              </option>
            </select>
          </div>
          <div class="dialog-form-item">
            <div class="dialog-form-item-label">{{ t.maxMoves }}</div>
            <input ref="maxMoves" class="number" type="number" min="1" />
          </div>
          <div class="dialog-form-item">
            <div class="dialog-form-item-label">{{ t.gameRepetition }}</div>
            <input ref="repeat" class="number" type="number" min="1" />
          </div>
          <div class="dialog-form-item">
            <input id="swap-players" ref="swapPlayers" type="checkbox" />
            <label for="swap-players">{{ t.swapTurnWhenGameRepetition }}</label>
          </div>
          <div class="dialog-form-item">
            <input id="enable-comment" ref="enableComment" type="checkbox" />
            <label for="enable-comment">{{ t.outputComments }}</label>
          </div>
          <div class="dialog-form-item">
            <input id="enable-auto-save" ref="enableAutoSave" type="checkbox" />
            <label for="enable-auto-save">{{
              t.saveRecordAutomatically
            }}</label>
          </div>
          <div class="dialog-form-item">
            <input id="human-is-front" ref="humanIsFront" type="checkbox" />
            <label for="human-is-front">{{ t.adjustBoardToHumanPlayer }}</label>
          </div>
        </div>
      </div>
      <div class="dialog-main-buttons">
        <button
          data-hotkey="Enter"
          autofocus
          class="dialog-button"
          @click="onStart()"
        >
          {{ t.startGame }}
        </button>
        <button class="dialog-button" data-hotkey="Escape" @click="onCancel()">
          {{ t.cancel }}
        </button>
      </div>
    </dialog>
  </div>
</template>

<script lang="ts">
import { t } from "@/common/i18n";
import { USIEngineSetting, USIEngineSettings } from "@/common/settings/usi";
import {
  ref,
  onMounted,
  defineComponent,
  Ref,
  onUpdated,
  onBeforeUnmount,
} from "vue";
import api, { isNative } from "@/renderer/ipc/api";
import { useStore } from "@/renderer/store";
import { CommentBehavior } from "@/common/settings/analysis";
import {
  defaultGameSetting,
  GameSetting,
  validateGameSetting,
  validateGameSettingForWeb,
} from "@/common/settings/game";
import { showModalDialog } from "@/renderer/helpers/dialog.js";
import * as uri from "@/common/uri.js";
import { readInputAsNumber } from "@/renderer/helpers/form.js";
import { Icon } from "@/renderer/assets/icons";
import ButtonIcon from "@/renderer/view/primitive/ButtonIcon.vue";
import PlayerSelector from "@/renderer/view/dialog/PlayerSelector.vue";
import { PlayerSetting } from "@/common/settings/player";
import {
  installHotKeyForDialog,
  uninstallHotKeyForDialog,
} from "@/renderer/keyboard/hotkey";

export default defineComponent({
  name: "GameDialog",
  components: {
    ButtonIcon,
    PlayerSelector,
  },
  setup() {
    const store = useStore();
    const dialog: Ref = ref(null);
    const hours: Ref = ref(null);
    const minutes: Ref = ref(null);
    const byoyomi: Ref = ref(null);
    const increment: Ref = ref(null);
    const startPosition: Ref = ref(null);
    const enableEngineTimeout: Ref = ref(null);
    const maxMoves: Ref = ref(null);
    const humanIsFront: Ref = ref(null);
    const repeat: Ref = ref(null);
    const swapPlayers: Ref = ref(null);
    const enableComment: Ref = ref(null);
    const enableAutoSave: Ref = ref(null);
    const gameSetting = ref(defaultGameSetting());
    const engineSettings = ref(new USIEngineSettings());
    const blackPlayerURI = ref("");
    const whitePlayerURI = ref("");

    let defaultValueLoaded = false;
    let defaultValueApplied = false;
    store.retainBussyState();

    onMounted(async () => {
      try {
        gameSetting.value = await api.loadGameSetting();
        engineSettings.value = await api.loadUSIEngineSetting();
        blackPlayerURI.value = gameSetting.value.black.uri;
        whitePlayerURI.value = gameSetting.value.white.uri;
        showModalDialog(dialog.value);
        installHotKeyForDialog(dialog.value);
        defaultValueLoaded = true;
      } catch (e) {
        store.pushError(e);
        store.destroyModalDialog();
      } finally {
        store.releaseBussyState();
      }
    });

    onBeforeUnmount(() => {
      uninstallHotKeyForDialog(dialog.value);
    });

    onUpdated(() => {
      if (!defaultValueLoaded || defaultValueApplied) {
        return;
      }
      hours.value.value = Math.floor(
        gameSetting.value.timeLimit.timeSeconds / 3600
      );
      minutes.value.value =
        Math.floor(gameSetting.value.timeLimit.timeSeconds / 60) % 60;
      byoyomi.value.value = gameSetting.value.timeLimit.byoyomi;
      increment.value.value = gameSetting.value.timeLimit.increment;
      startPosition.value.value =
        gameSetting.value.startPosition !== undefined
          ? gameSetting.value.startPosition
          : "current";
      enableEngineTimeout.value.checked = gameSetting.value.enableEngineTimeout;
      maxMoves.value.value = gameSetting.value.maxMoves;
      humanIsFront.value.checked = gameSetting.value.humanIsFront;
      repeat.value.value = gameSetting.value.repeat;
      swapPlayers.value.checked = gameSetting.value.swapPlayers;
      enableComment.value.checked = gameSetting.value.enableComment;
      enableAutoSave.value.checked = gameSetting.value.enableAutoSave;
      defaultValueApplied = true;
    });

    const buildPlayerSetting = (playerURI: string): PlayerSetting => {
      if (
        uri.isUSIEngine(playerURI) &&
        engineSettings.value.hasEngine(playerURI)
      ) {
        const engine = engineSettings.value.getEngine(
          playerURI
        ) as USIEngineSetting;
        return {
          name: engine.name,
          uri: playerURI,
          usi: engine,
        };
      }
      return {
        name: "人",
        uri: uri.ES_HUMAN,
      };
    };

    const onStart = () => {
      const gameSetting: GameSetting = {
        black: buildPlayerSetting(blackPlayerURI.value),
        white: buildPlayerSetting(whitePlayerURI.value),
        timeLimit: {
          timeSeconds:
            (readInputAsNumber(hours.value) * 60 +
              readInputAsNumber(minutes.value)) *
            60,
          byoyomi: readInputAsNumber(byoyomi.value),
          increment: readInputAsNumber(increment.value),
        },
        startPosition:
          startPosition.value.value !== "current"
            ? startPosition.value.value
            : undefined,
        enableEngineTimeout: enableEngineTimeout.value.checked,
        maxMoves: readInputAsNumber(maxMoves.value),
        humanIsFront: humanIsFront.value.checked,
        repeat: readInputAsNumber(repeat.value),
        swapPlayers: swapPlayers.value.checked,
        enableComment: enableComment.value.checked,
        enableAutoSave: enableAutoSave.value.checked,
      };
      const error = isNative()
        ? validateGameSetting(gameSetting)
        : validateGameSettingForWeb(gameSetting);
      if (error) {
        store.pushError(error);
      } else {
        store.startGame(gameSetting);
      }
    };

    const onCancel = () => {
      store.closeModalDialog();
    };

    const onUpdatePlayerSetting = (settings: USIEngineSettings) => {
      engineSettings.value = settings;
    };

    const onSelectBlackPlayer = (uri: string) => {
      blackPlayerURI.value = uri;
    };
    const onSelectWhitePlayer = (uri: string) => {
      whitePlayerURI.value = uri;
    };

    const onSwapColor = () => {
      [blackPlayerURI.value, whitePlayerURI.value] = [
        whitePlayerURI.value,
        blackPlayerURI.value,
      ];
    };

    return {
      t,
      CommentBehavior,
      dialog,
      hours,
      minutes,
      byoyomi,
      increment,
      startPosition,
      enableEngineTimeout,
      maxMoves,
      humanIsFront,
      repeat,
      swapPlayers,
      enableComment,
      enableAutoSave,
      engineSettings,
      blackPlayerURI,
      whitePlayerURI,
      onStart,
      onCancel,
      onUpdatePlayerSetting,
      onSelectBlackPlayer,
      onSelectWhitePlayer,
      onSwapColor,
      Icon,
    };
  },
});
</script>

<style scoped>
.top-label {
  text-align: center;
}
.dialog-form-area {
  width: 520px;
  display: flex;
  flex-direction: column;
}
.players {
  display: flex;
  flex-direction: row;
  justify-content: space-evenly;
  width: 100%;
}
.player {
  width: 250px;
}
.players-control {
  width: 100%;
}
.players-control > * {
  margin-top: 5px;
}
.dialog-form-area.time-limit {
  width: 260px;
}
input.time {
  text-align: right;
  width: 40px;
}
input.number {
  text-align: right;
  width: 80px;
}
.dialog-form-area.flags {
  width: 225px;
}
</style>
