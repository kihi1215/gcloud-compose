## centos8 に gcloud の開発環境をユーザ毎に作ってみる

コンテナを新規作成したときに、毎回 `gcloud init` を実行したくないので、ユーザ情報などが保存されているディレクトリ（ .config/gcloud ）をボリュームマウントするようにした。
コンテナとボリュームの関係は composer でまとめておいた。

コンテナイメージは dockerhub の [kihi1215/gcloud](https://hub.docker.com/repository/docker/kihi1215/gcloud) を使用する。

dummy はイメージをローカルに作るタメだけのコンテナ。実際に使うコンテナの一つ目だけ build であとは image を使えばいいのだけれど、実際に使うコンテナの記述を統一したかったので、あえてダミーを作ってある。composer でイメージを作るだけの記述ってできないのかな。

実際は、プロジェクト毎にコンテナを作って、プロジェクトに必要な物だけがインストールして使うけれど、デフォルトプロジェクトの設定までボリュームで分けると、ボリュームにしてる意味もよくわかんなくなるので、とりあえずユーザ毎にしてみた。

プロジェクトの切り替えは、ログイン時のシェルとかでもいいかなという感じ。

[gcloud config configurations](https://cloud.google.com/sdk/gcloud/reference/config/configurations?hl=ja) だと、ユーザとプロジェクトとその他もろもろぜんぶセットで切り替えてくれるっぽいので、ボリュームマウントいらないのかも。
ただし事前に `gcloud config configurations create` で作成しておかないとだめ。

`gcloud config configurations active` を使って切り替えると、保存もとが .config/gcloud っぽいので両方のコンテナの設定が変わるので、同時に開発してるとダメみたい。

しかし、[ここ](https://cloud.google.com/sdk/docs/configurations?hl=ja) の CLOUDSDK_ACTIVE_CONFIG_NAME という環境変数を使うとのが良さそう。
これだとコンテナ毎に設定が異なる状態になってくれるのでいい感じ。ただし全てのコンテナに環境変数を設定しないと引きずられてしまうみたい。

[ここ](https://cloud.google.com/sdk/docs/properties?hl=ja) に書いてあるように、プロジェクトやリージョンなど個別の環境変数で設定するのもありみたいだけど、 CLOUDSDK_ACTIVE_CONFIG_NAME の方が事前準備は必要だけど便利かな。


あとは、 .config/gcloud 全体を共有しているので、ログが入り乱れてそうで怖いから、 `gcloud info` で表示されている User Config Directory の設定を(例えば/root/.config/gcloud-configに)変更して、そこをボリュームマウントしてもいい。
同じく Logs Directory も設定できるようだが、これはこのままがいいかな。イメージ作成時にマウントする為に既存の.config/gcloud を.config/gcloud-old にリネームしてるのとかもいらなくなりそうだし。

この辺りの作業は後日。