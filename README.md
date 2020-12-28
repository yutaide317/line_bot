# README

# Line bot
### テキストとスタンプに反応してランダムなメッセージ、スタンプを返すbot
[![Image from Gyazo](https://i.gyazo.com/c85180b8a9d6d9fc42f9c5e362597d2e.gif)](https://gyazo.com/c85180b8a9d6d9fc42f9c5e362597d2e)

### 投稿されたテキストをランダムで返す
[![Image from Gyazo](https://i.gyazo.com/8886a961b219d3b2a0446ec583b50334.gif)](https://gyazo.com/8886a961b219d3b2a0446ec583b50334)

### 機能一覧
|機能|概要|
|------|-------|
|テキスト返信|テキストメッセージに対して登録したメッセージをランダムで返信する|
|特定の文字を特定のテキストメッセージで返信|「運勢」とテキストを打ったら運勢を占うなど|
|スタンプ返信|スタンプを送ってきたらスタンプをランダムで返信する|

### 追加予定機能
  - プッシュメッセージをできるようにする
  - 他のAPIとつなげて検索機能を実装する

### 開発環境
ruby 2.6.5
rails 6.0.0
heroku
mysql

### DB設計
#### Postテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
