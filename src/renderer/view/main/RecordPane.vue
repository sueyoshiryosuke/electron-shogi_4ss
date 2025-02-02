<template>
  <div ref="root" class="record-pane">
    <div class="record">
      <RecordView
        :record="store.record"
        :operational="isRecordOperational"
        :show-comment="appSetting.showCommentInRecordView"
        :show-elapsed-time="appSetting.showElapsedTimeInRecordView"
        @go-begin="goBegin"
        @go-back="goBack"
        @go-forward="goForward"
        @go-end="goEnd"
        @select-move="selectMove"
        @select-branch="selectBranch"
        @swap-with-previous-branch="swapWithPreviousBranch"
        @swap-with-next-branch="swapWithNextBranch"
      />
    </div>
    <div class="options">
      <div class="option">
        <input
          id="show-elapsed-time"
          type="checkbox"
          :checked="appSetting.showElapsedTimeInRecordView"
          @change="onToggleElapsedTime"
        />
        <label for="show-elapsed-time">{{ t.elapsedTime }}</label>
      </div>
      <div class="option">
        <input
          id="show-comment"
          type="checkbox"
          :checked="appSetting.showCommentInRecordView"
          @change="onToggleComment"
        />
        <label for="show-comment">{{ t.comments }}</label>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { t } from "@/common/i18n";
import { computed, defineComponent, onMounted, onUnmounted, ref } from "vue";
import RecordView from "@/renderer/view/primitive/RecordView.vue";
import { useStore } from "@/renderer/store";
import { AppState } from "@/common/control/state.js";
import {
  installHotKeyForMainWindow,
  uninstallHotKeyForMainWindow,
} from "@/renderer/keyboard/hotkey";
import { useAppSetting } from "@/renderer/store/setting";

export const minWidth = 200;

export default defineComponent({
  name: "RecordPane",
  components: {
    RecordView,
  },
  setup() {
    const store = useStore();
    const appSetting = useAppSetting();
    const root = ref();

    onMounted(() => {
      installHotKeyForMainWindow(root.value);
    });

    onUnmounted(() => {
      uninstallHotKeyForMainWindow(root.value);
    });

    const goto = (ply: number) => {
      store.changePly(ply);
    };

    const goBegin = () => {
      goto(0);
    };

    const goBack = () => {
      goto(store.record.current.number - 1);
    };

    const goForward = () => {
      goto(store.record.current.number + 1);
    };

    const goEnd = () => {
      goto(Number.MAX_SAFE_INTEGER);
    };

    const selectMove = (ply: number) => {
      goto(ply);
    };

    const selectBranch = (index: number) => {
      store.changeBranch(index);
    };

    const swapWithPreviousBranch = () => {
      store.swapWithPreviousBranch();
    };

    const swapWithNextBranch = () => {
      store.swapWithNextBranch();
    };

    const onToggleElapsedTime = (event: Event) => {
      const checkbox = event.target as HTMLInputElement;
      appSetting.updateAppSetting({
        showElapsedTimeInRecordView: checkbox.checked,
      });
    };

    const onToggleComment = (event: Event) => {
      const checkbox = event.target as HTMLInputElement;
      appSetting.updateAppSetting({
        showCommentInRecordView: checkbox.checked,
      });
    };

    const isRecordOperational = computed(() => {
      return (
        store.appState === AppState.NORMAL ||
        store.appState === AppState.RESEARCH
      );
    });

    return {
      t,
      store,
      appSetting,
      root,
      isRecordOperational,
      goBegin,
      goBack,
      goForward,
      goEnd,
      selectMove,
      selectBranch,
      swapWithPreviousBranch,
      swapWithNextBranch,
      onToggleElapsedTime,
      onToggleComment,
    };
  },
});
</script>

<style scoped>
.record-pane {
  box-sizing: border-box;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}
.record {
  width: 100%;
  min-height: 0;
  flex: auto;
}
.options {
  width: 100%;
  margin-top: 2px;
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  align-items: flex-start;
}
.option {
  white-space: nowrap;
  padding: 0 10px 0 10px;
}
</style>
