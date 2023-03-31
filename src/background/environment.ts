import { app, shell } from "electron";
import path from "path";

export function isDevelopment(): boolean {
  return process.env.npm_lifecycle_event === "electron:serve" && !isTest();
}

export function isPreview(): boolean {
  return process.env.npm_lifecycle_event === "electron:preview";
}

export function isTest(): boolean {
  return process.env.NODE_ENV === "test";
}

export function isProduction(): boolean {
  return !isDevelopment() && !isPreview() && !isTest();
}

export function isPortable(): boolean {
  // 実行ファイルのフォルダでportable版かを判断している。
  //return process.env.PORTABLE_EXECUTABLE_DIR !== undefined;
  // 将スタカスタム版では強制的にportable版と判断させる。
  return true;
}

export function getPortableExeDir(): string | undefined {
  //return process.env.PORTABLE_EXECUTABLE_DIR;
  // 将スタカスタム版では、そのままexeの実行フォルダを出力する。
  return path.dirname(app.getPath("exe"));
}
