import { shell } from "electron";

export function openWebSite(): void {
  shell.openExternal("https://github.com/sueyoshiryosuke/electron-shogi_4ss");
}

export function openHowToUse(): void {
  shell.openExternal(
    "https://github.com/sueyoshiryosuke/electron-shogi_4ss/wiki"
  );
}

export function checkLatestVersion(): void {
  shell.openExternal(
    "https://github.com/sunfish-shogi/electron-shogi/releases/latest"
  );
}
