## centos8 に gcloud の開発環境をユーザ毎に作ってみる

コンテナを新規作成したときに、毎回 `gcloud init` を実行したくないので、ユーザ情報などが保存されているディレクトリ（ .config/gcloud ）をボリュームマウントするようにした。
コンテナとボリュームの関係は composer でまとめておいた。

コンテナイメージは dockerhub の [kihi1215/gcloud](https://hub.docker.com/repository/docker/kihi1215/gcloud) を使用する。

dummy はイメージをローカルに作るタメだけのコンテナ。実際に使うコンテナの一つ目だけ build であとは image を使えばいいのだけれど、実際に使うコンテナの記述を統一したかったので、あえてダミーを作ってある。composer でイメージを作るだけの記述ってできないのかな。

実際は、プロジェクト毎にコンテナを作って、プロジェクトに必要な物だけがインストールして使うけれど、デフォルトプロジェクトの設定までボリュームで分けると、ボリュームにしてる意味もよくわかんなくなるので、とりあえずユーザ毎にしてみた。

プロジェクトの切り替えは、ログイン時のシェルとかでもいいかなという感じ。

[gcloud config configurations](https://cloud.google.com/sdk/gcloud/reference/config/configurations?hl=ja) だと、ユーザとプロジェクトとその他もろもろぜんぶセットで切り替えてくれるっぽいので、ボリュームマウントいらないのかも。
