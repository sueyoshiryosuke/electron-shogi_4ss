<template>
  <div>
    <div class="root">
      <div class="headers">
        <div class="header">
          <span class="label">{{ t.name }}: </span>
          <span class="value">{{ name }}</span>
        </div>
        <div class="header">
          <span class="label">{{ t.prediction }}: </span>
          <span class="value">
            {{ info.ponderMove ? info.ponderMove : "---" }}
          </span>
        </div>
        <div class="header">
          <span class="label">{{ t.best }}: </span>
          <span class="value">{{ info.currentMoveText || "---" }}</span>
        </div>
        <div class="header">
          <span class="label">NPS: </span>
          <span class="value">{{ info.nps || "---" }}</span>
        </div>
        <div class="header">
          <span class="label">{{ t.nodes }}: </span>
          <span class="value">{{ info.nodes || "---" }}</span>
        </div>
        <div class="header">
          <span class="label">{{ t.hashUsage }}: </span>
          <span class="value">
            {{ info.hashfull ? (info.hashfull * 100).toFixed(1) : "---" }} %
          </span>
        </div>
      </div>
      <div class="list-header">
        <div class="list-column time">{{ t.elapsed }}</div>
        <div class="list-column multipv-index">{{ t.rank }}</div>
        <div class="list-column depth">{{ t.depth }}</div>
        <div class="list-column nodes">{{ t.nodes }}</div>
        <div class="list-column score">{{ t.eval }}</div>
      </div>
      <div class="list" :style="{ height: `${height - 37}px` }">
        <div
          v-for="(iterate, index) in historyMode
            ? info.iterates
            : info.latestIteration"
          :key="index"
          class="list-item"
          :class="{ highlight: enableHighlight && iterate.multiPV === 1 }"
        >
          <div class="list-column time">
            {{ iterate.timeMs ? (iterate.timeMs / 1e3).toFixed(1) + "s" : "" }}
          </div>
          <div class="list-column multipv-index">
            {{ iterate.multiPV || "" }}
          </div>
          <div class="list-column depth">
            {{ iterate.depth
            }}{{ iterate.selectiveDepth && iterate.depth ? "/" : ""
            }}{{ iterate.selectiveDepth }}
          </div>
          <div class="list-column nodes">
            {{ iterate.nodes }}
          </div>
          <div class="list-column score">
            {{
              iterate.scoreMate
                ? getDisplayScore(
                    iterate.scoreMate,
                    iterate.color,
                    evaluationViewFrom
                  )
                : iterate.score
                ? getDisplayScore(
                    iterate.score,
                    iterate.color,
                    evaluationViewFrom
                  )
                : ""
            }}
          </div>
          <div class="list-column score-flag">
            {{ iterate.lowerBound ? "++" : "" }}
            {{ iterate.upperBound ? "--" : "" }}
            {{ iterate.scoreMate ? t.mateShort : "" }}
          </div>
          <div class="list-column text">
            <button
              v-if="iterate.pv && iterate.pv.length !== 0 && iterate.text"
              @click="showPreview(iterate)"
            >
              <ButtonIcon class="icon" :icon="Icon.PLAY" />
              <span>{{ t.displayPVShort }}</span>
            </button>
            {{ iterate.text }}
          </div>
        </div>
      </div>
      <PVPreviewDialog
        v-if="preview"
        :position="preview.position"
        :pv="preview.pv"
        :infos="preview.infos"
        @close="closePreview"
      />
    </div>
  </div>
</template>

<script lang="ts">
import { t } from "@/common/i18n";
import { USIIteration, USIPlayerMonitor } from "@/renderer/store/usi";
import { computed, defineComponent, ref } from "vue";
import { Icon } from "@/renderer/assets/icons";
import ButtonIcon from "@/renderer/view/primitive/ButtonIcon.vue";
import PVPreviewDialog from "@/renderer/view/dialog/PVPreviewDialog.vue";
import { EvaluationViewFrom } from "@/common/settings/app";
import { Color } from "@/common/shogi";
import { useAppSetting } from "@/renderer/store/setting";

type Preview = {
  position: string;
  pv: string[];
  infos: string[];
};

export default defineComponent({
  name: "EngineAnalyticsElement",
  components: {
    ButtonIcon,
    PVPreviewDialog,
  },
  props: {
    historyMode: {
      type: Boolean,
      required: true,
    },
    name: {
      type: String,
      required: true,
    },
    info: {
      type: USIPlayerMonitor,
      required: true,
    },
    height: {
      type: Number,
      required: true,
    },
  },
  setup: (props) => {
    const enableHighlight = computed(() => {
      if (!props.historyMode) {
        return false;
      }
      for (const iterate of props.info.iterates) {
        if (iterate.multiPV && iterate.multiPV !== 1) {
          return true;
        }
      }
      return false;
    });

    const preview = ref<Preview | null>(null);

    const evaluationViewFrom = computed(() => {
      return useAppSetting().evaluationViewFrom;
    });
    const getDisplayScore = (
      score: number,
      color: Color,
      evaluationViewFrom: EvaluationViewFrom
    ) => {
      return evaluationViewFrom === EvaluationViewFrom.EACH ||
        color == Color.BLACK
        ? score
        : -score;
    };

    const showPreview = (ite: USIIteration) => {
      const infos = [];
      if (ite.depth !== undefined) {
        infos.push(`深さ=${ite.depth}`);
      }
      if (ite.selectiveDepth !== undefined) {
        infos.push(`選択的深さ=${ite.selectiveDepth}`);
      }
      if (ite.score) {
        infos.push(
          `評価値=${getDisplayScore(
            ite.score,
            ite.color,
            evaluationViewFrom.value
          )}`
        );
        if (ite.lowerBound) {
          infos.push("（下界値）");
        }
        if (ite.upperBound) {
          infos.push("（上界値）");
        }
      }
      if (ite.scoreMate) {
        infos.push(
          `詰み手数=${getDisplayScore(
            ite.scoreMate,
            ite.color,
            evaluationViewFrom.value
          )}`
        );
      }
      if (ite.multiPV) {
        infos.push(`順位=${ite.multiPV}`);
      }
      preview.value = {
        position: ite.position,
        pv: ite.pv || [],
        infos: [infos.join(" / ")],
      };
    };

    const closePreview = () => {
      preview.value = null;
    };

    return {
      t,
      Icon,
      enableHighlight,
      preview,
      evaluationViewFrom,
      getDisplayScore,
      showPreview,
      closePreview,
    };
  },
});
</script>

<style scoped>
.root {
  width: 100%;
  height: 100%;
  padding-bottom: 2px;
  display: flex;
  flex-direction: column;
  background-color: var(--active-tab-bg-color);
}
.headers {
  width: 100%;
  height: 18px;
  text-align: left;
  display: flex;
  flex-direction: row;
}
.header {
  margin: 0px 4px 0px 0px;
  padding: 0px 5px 0px 5px;
  background-color: var(--text-bg-color);
}
.label {
  font-size: 13px;
  white-space: nowrap;
}
.value {
  font-size: 13px;
  white-space: nowrap;
}
.list-header {
  height: 16px;
  width: 100%;
  font-size: 12px;
  background-color: var(--text-bg-color);
  display: flex;
  flex-direction: row;
}
.list {
  width: 100%;
  overflow-y: scroll;
  background-color: var(--text-bg-color);
}
.list-item {
  height: 24px;
  font-size: 12px;
  display: flex;
  flex-direction: row;
}
.list-item.highlight {
  background: var(--text-bg-color-warning);
  border-bottom: dashed var(--text-separator-color) 1px;
}
.list-column {
  height: 100%;
  white-space: nowrap;
  overflow: hidden;
  line-height: 22px;
}
.list-column.multipv-index {
  width: 30px;
  text-align: right;
}
.list-column.depth {
  width: 44px;
  text-align: right;
}
.list-column.nodes {
  width: 78px;
  text-align: right;
}
.list-column.time {
  width: 52px;
  text-align: right;
}
.list-column.score {
  width: 52px;
  text-align: right;
}
.list-column.score-flag {
  width: 20px;
  text-align: left;
}
.list-column.text {
  flex: 1;
  text-align: left;
  text-overflow: ellipsis;
}
.list-column button {
  margin: 0px 0px 1px 0px;
  padding: 1px 5px 1px 2px;
  height: 22px;
  vertical-align: middle;
}
.list-column .icon {
  height: 18px;
  vertical-align: top;
}
.list-column button span {
  line-height: 19px;
}
</style>
