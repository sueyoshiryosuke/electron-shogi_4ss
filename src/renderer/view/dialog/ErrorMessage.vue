<template>
  <div>
    <dialog ref="dialog" class="error">
      <div class="message-box">
        <ButtonIcon class="icon" :icon="Icon.ERROR" />
        <div class="items">
          <div class="notice">
            {{ t.errorsOccurred(store.errors.length) }}
          </div>
          <div v-for="(error, index) in store.errors" :key="index" class="item">
            <p class="index">
              {{ index + 1 }}
              <span v-if="error.count >= 2">({{ error.count }} 回)</span>
            </p>
            <p class="message">{{ error.message }}</p>
          </div>
        </div>
      </div>
      <div class="dialog-main-buttons">
        <button autofocus data-hotkey="Escape" @click="onClose()">
          {{ t.close }}
        </button>
      </div>
    </dialog>
  </div>
</template>

<script lang="ts">
import { t } from "@/common/i18n";
import { useStore } from "@/renderer/store";
import { defineComponent, onBeforeUnmount, onMounted, ref, Ref } from "vue";
import { showModalDialog } from "@/renderer/helpers/dialog.js";
import ButtonIcon from "@/renderer/view/primitive/ButtonIcon.vue";
import { Icon } from "@/renderer/assets/icons";
import {
  installHotKeyForDialog,
  uninstallHotKeyForDialog,
} from "@/renderer/keyboard/hotkey";

export default defineComponent({
  name: "ErrorMessage",
  components: {
    ButtonIcon,
  },
  setup() {
    const store = useStore();
    const dialog: Ref = ref(null);

    onMounted(() => {
      showModalDialog(dialog.value);
      installHotKeyForDialog(dialog.value);
    });

    onBeforeUnmount(() => {
      uninstallHotKeyForDialog(dialog.value);
    });

    const onClose = () => {
      store.clearErrors();
    };

    return {
      t,
      dialog,
      store,
      onClose,
      Icon,
    };
  },
});
</script>

<style scoped>
.items {
  display: flex;
  flex-direction: column;
}
.item {
  margin: 10px 0px 10px 0px;
}
.index {
  font-weight: bold;
  font-size: 0.8em;
  margin: 0px;
}
.message {
  font-size: 0.8em;
  margin: 0px;
}
</style>

<style scoped>
dialog.error {
  color: var(--error-dialog-color);
  background-color: var(--error-dialog-bg-color);
  border: 3px solid var(--error-dialog-border-color);
}

dialog.error button {
  color: var(--error-dialog-button-color);
  background: linear-gradient(
    to top,
    var(--error-dialog-button-bg-color) 80%,
    white 140%
  );
}
dialog.error button:hover {
  background: linear-gradient(
    to top,
    var(--hovered-error-dialog-button-bg-color) 80%,
    white 140%
  );
}
</style>
