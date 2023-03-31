# Electron将棋for将スタ

将棋の GUI アプリ「Electron将棋」を将スタ用にカスタマイズしたものです。

[将棋所](http://shogidokoro.starfree.jp/)と同様に [USI プロトコル](http://shogidokoro.starfree.jp/usi.html) 対応の思考エンジンを利用できます。


## 使い方

（準備中）


## ダウンロード

（準備中）


## ビルド方法の説明（開発者向け）
npm run electron:zip でzip版をビルドすることができます。

Windows のみで有効です。


### 成果物

electron-builder により、zip ファイル（ElectronShogi4ss-1.6.0-p-win.zip）が dist ディレクトリに出力されます。


### ビルド後のリリース用ファイル作成の手順

ElectronShogi4ss-1.6.0-p-win.zipを展開する。

\electron-shogi_4ss\set_electron-shogi_4ssフォルダの中の

3つのフォルダと1つのファイルを、展開したフォルダ（set_electron-shogi_4ss）にコピーする。

set_electron-shogi_4ssフォルダが配布できるもの。（1つにzip圧縮したりしても良い）


### 設定ファイル

設定ファイルは、以下のディレクトリに生成されます。


#### exe と同じディレクトリに配置される設定ファイル

　usi_engine.json : USI エンジン設定

　game_setting.json : 対局設定

　csa_game_setting_history.json : CSA プロトコル対局設定

　research_setting.json : 検討設定

　analysis_setting.json : 棋譜解析設定


#### exe と同じディレクトリ¥settingに配置される設定ファイル

　app_setting.json : アプリ設定

　window.json : ウィンドウ設定


#### %USERPROFILE%\AppData\Roaming\electron-shogi_4ss に配置される設定ファイル

　（なし）


エンジンを追加したとき、 exe と同じディレクトリ下（直下以外も含む）であれば、相対パスで設定に記録されます。

そうでない場合は絶対パスで記録されます。


### 参考

https://github.com/sunfish-shogi/electron-shogi/pull/420


## Licences

### Electron Shogi 4ss

[MIT License](LICENSE)

### Icon Images

[/public/icon](https://github.com/sunfish-shogi/electron-shogi/tree/main/public/icon) 配下のアイコン画像は [Material Icons](https://google.github.io/material-design-icons/) を使用しています。
これには [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0.txt) が適用されます。

### Dependencies

レンダラープロセスで使用しているライブラリはElectron将棋の [THIRD PARTY LICENSES](https://sunfish-shogi.github.io/electron-shogi/third-party-licenses.html) を参照してください。

Electron と Chromium については electron-builder によって成果物にバンドルされます。

