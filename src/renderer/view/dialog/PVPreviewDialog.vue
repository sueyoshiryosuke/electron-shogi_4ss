<template>
  <div>
    <dialog ref="dialog">
      <BoardView
        class="board"
        :piece-image-type="appSetting.pieceImage"
        :board-image-type="appSetting.boardImage"
        :board-label-type="appSetting.boardLabelType"
        :max-size="maxSize"
        :position="record.position"
        :last-move="lastMove"
        :flip="flip"
      >
        <template #right-control>
          <div class="control top">
            <div class="control-row">
              <button
                class="control-item"
                data-hotkey="Control+t"
                @click="doFlip"
              >
                <ButtonIcon class="icon" :icon="Icon.FLIP" />
              </button>
              <button
                class="control-item"
                autofocus
                data-hotkey="Escape"
                @click="close"
              >
                <ButtonIcon class="icon" :icon="Icon.CLOSE" />
              </button>
            </div>
            <div class="control-row">
              <button
                class="control-item"
                data-hotkey="ArrowLeft"
                @click="goBegin"
              >
                <ButtonIcon class="icon" :icon="Icon.FIRST" />
              </button>
              <button
                class="control-item"
                data-hotkey="ArrowRight"
                @click="goEnd"
              >
                <ButtonIcon class="icon" :icon="Icon.LAST" />
              </button>
            </div>
            <div class="control-row">
              <button
                class="control-item"
                data-hotkey="ArrowUp"
                @click="goBack"
              >
                <ButtonIcon class="icon" :icon="Icon.BACK" />
              </button>
              <button
                class="control-item"
                data-hotkey="ArrowDown"
                @click="goForward"
              >
                <ButtonIcon class="icon" :icon="Icon.NEXT" />
              </button>
            </div>
          </div>
        </template>
      </BoardView>
      <div class="informations">
        <div v-for="(info, index) in infos" :key="index" class="information">
          {{ info }}
        </div>
        <div class="information">
          <span v-for="(move, index) in displayPV" :key="index">
            <span class="move-element" :class="{ selected: move.selected }"
              >&nbsp;{{ move.text }}&nbsp;</span
            >
          </span>
        </div>
      </div>
    </dialog>
  </div>
</template>

<script lang="ts">
import { Move, Position, Record } from "@/common/shogi";
import {
  defineComponent,
  onMounted,
  PropType,
  Ref,
  ref,
  reactive,
  watch,
  onBeforeUnmount,
} from "vue";
import BoardView from "@/renderer/view/primitive/BoardView.vue";
import ButtonIcon from "@/renderer/view/primitive/ButtonIcon.vue";
import { RectSize } from "@/common/graphics.js";
import { computed } from "vue";
import { showModalDialog } from "@/renderer/helpers/dialog.js";
import { Icon } from "@/renderer/assets/icons";
import {
  installHotKeyForDialog,
  uninstallHotKeyForDialog,
} from "@/renderer/keyboard/hotkey";
import { useAppSetting } from "@/renderer/store/setting";

export default defineComponent({
  name: "PVPreviewDialog",
  components: { BoardView, ButtonIcon },
  props: {
    position: {
      type: String,
      required: true,
    },
    pv: {
      type: Array as PropType<string[]>,
      required: true,
    },
    infos: {
      type: Array as PropType<string[]>,
      default: [] as string[],
      required: false,
    },
  },
  emits: ["close"],
  setup(props, context) {
    const appSetting = useAppSetting();
    const dialog: Ref = ref(null);
    const maxSize = reactive(new RectSize(0, 0));
    const record = reactive(new Record());
    const flip: Ref<boolean> = ref(appSetting.boardFlipping);

    const updateSize = () => {
      maxSize.width = window.innerWidth * 0.8;
      maxSize.height = window.innerHeight * 0.8 - 80;
    };

    const updateRecord = () => {
      const position = Position.newBySFEN(props.position);
      if (!position) {
        return;
      }
      record.clear(position);
      for (const usiMove of props.pv) {
        const move = record.position.createMoveByUSI(usiMove);
        if (!move) {
          break;
        }
        record.append(move, { ignoreValidation: true });
      }
      record.goto(1);
    };

    onMounted(async () => {
      updateSize();
      updateRecord();
      window.addEventListener("resize", updateSize);
      showModalDialog(dialog.value);
      installHotKeyForDialog(dialog.value);
    });

    onBeforeUnmount(() => {
      window.removeEventListener("resize", updateSize);
      uninstallHotKeyForDialog(dialog.value);
    });

    watch([() => props.position, () => props.pv], () => {
      updateRecord();
      showModalDialog(dialog.value);
    });

    const close = () => {
      context.emit("close");
    };

    const goBegin = () => {
      record.goto(0);
    };

    const goEnd = () => {
      record.goto(Number.MAX_SAFE_INTEGER);
    };

    const goBack = () => {
      record.goBack();
    };

    const goForward = () => {
      record.goForward();
    };

    const doFlip = () => {
      flip.value = !flip.value;
    };

    const lastMove = computed(() =>
      record.current.move instanceof Move ? record.current.move : null
    );

    const displayPV = computed(() => {
      return record.moves.slice(1).map((move) => {
        return {
          text: move.displayText,
          selected: move.number === record.current.number,
        };
      });
    });

    return {
      dialog,
      appSetting,
      record,
      lastMove,
      maxSize,
      flip,
      displayPV,
      close,
      goBegin,
      goEnd,
      goBack,
      goForward,
      doFlip,
      Icon,
    };
  },
});
</script>

<style scoped>
.board {
  margin-left: auto;
  margin-right: auto;
}
.control {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}
.control-row {
  width: 100%;
  height: 25%;
  margin: 0px;
  display: flex;
  flex-direction: row;
}
.control .control-item {
  width: 50%;
  height: 100%;
  margin: 0px;
  font-size: 100%;
  padding: 0 5% 0 5%;
}
.control.top .control-row:not(:last-child) {
  margin-bottom: 2%;
}
.control.top .control-item:not(:last-child) {
  margin-right: 2%;
}
.control .control-item .icon {
  height: 80%;
  width: auto;
  vertical-align: top;
}
.informations {
  height: 120px;
  width: 80vw;
  overflow-y: scroll;
  margin-left: auto;
  margin-right: auto;
  color: var(--text-color);
  background-color: var(--text-bg-color);
}
.information {
  font-size: 14px;
  margin: 2px;
  text-align: left;
}
.move-element.selected {
  background-color: var(--text-bg-color-selected);
}
</style>
