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
  // ���s�t�@�C���̃t�H���_��portable�ł��𔻒f���Ă���B
  //return process.env.PORTABLE_EXECUTABLE_DIR !== undefined;
  // ���X�^�J�X�^���łł͋����I��portable�łƔ��f������B
  return true;
}

export function getPortableExeDir(): string | undefined {
  //return process.env.PORTABLE_EXECUTABLE_DIR;
  // ���X�^�J�X�^���łł́A���̂܂�exe�̎��s�t�H���_���o�͂���B
  return path.dirname(app.getPath("exe"));
}
