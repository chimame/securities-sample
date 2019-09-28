# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

メモ
いいね数やシェア数を取得する方法
【twitter】
APIの制限がきついのでできれば自前で実装したくない。なので、https://jsoon.digitiminimi.com/を使用することで取得するようにする。ただし、twitterのアカウントが必要ぽいので、公式アカウントを別途用意。
【facebook】
APIが提供されているのでそれを使用する。ただし、facebookのアカウントが必要ぽいので、公式アカウントを別途用意。
https://developers.facebook.com/docs/graph-api?locale=ja_JP
【はてぶ】
APIが提供されており、複数URLが一度に取れるので、そこまで問題ないかも
http://developer.hatena.ne.jp/ja/documents/bookmark/apis/getcount
【Pocket】
こいつが一番めんどう。正直ブックマーク？数が必要ですか？ってレベルで実装が難しいというか力技になる。（HTMLを取得してパスする）

これらを1日1回？夜間ぐらいのバッチで取得して、ページに埋め込んでおく。記事のシェアに関してはリンクでどうとでもなるのでただのリンクにしておく。