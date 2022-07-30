# 説明
[ゼロからのOS自作入門](https://zero.osdev.jp/) で開発するOS (MikanOS) の
開発環境が設定された [VSCode Devcontainer](https://code.visualstudio.com/docs/remote/containers) 設定ファイルである[MikanOS-devcontainer](https://github.com/karaage0703/mikanos-devcontainer)に主にマシン再起動時などに毎回行う行程を少なくするための変更を加えたもの。

環境：MacOS

# 使い方
基本の使い方は[MikanOS-devcontainer](https://github.com/karaage0703/mikanos-devcontainer)のREADMEを参照してください。

ゲストOS側でセットアップ（リポジトリのクローンなど）が終わっている状態で、Macを再起動した後に行う必要のある作業は以下。
- XQuarts起動
- ターミナルで
```
xhost + 127.0.0.1
```

- VSCodeでmikanos-devcontainerのフォルダを開き、コンテナの中に入る
- コンテナ内で
```
source init_mikan.sh
```
# init_mikan.sh内の処理
- ブートローダディレクトリのリンクをedk2ディレクトリに作成
- edk2の初期化スクリプト実行
- edk2のターゲットファイルを置き換え
- edk2設定ファイルにApple Silicon用のパッチを適用
- 起動用のコマンドを設定
