# 掃除提案アプリ
<img width="1000" src="https://user-images.githubusercontent.com/72062153/99920826-920be080-2d69-11eb-8580-beba27259393.png">

# 概要
・このアプリケーションは登録した掃除情報から、毎日の掃除箇所を提案します。

・提案された掃除箇所を掃除することで、部屋の清潔が保たれます。

・画像投稿機能もあります。きれいになった自慢のデスク等の画像を共有しましょう！

# URL
・http://54.249.183.197/
・ID：   admin
・Pass： 1234

# 利用方法

1. 新規登録ボタンをクリックし、ユーザー情報を登録します。
<img width="1000" src="https://user-images.githubusercontent.com/72062153/99924238-c046eb80-2d7c-11eb-9fa7-16e731ce3c68.png">
<img width="1000" src="https://user-images.githubusercontent.com/72062153/99924268-e2406e00-2d7c-11eb-93c7-a743c30b86f5.png">

2. 「今日の掃除箇所を決める」ボタンをクリックします。
<img width="1000" src="https://user-images.githubusercontent.com/72062153/99920924-2d9d5100-2d6a-11eb-81aa-d424c304a26a.png">

3. 「登録する」ボタンをクリックし、掃除場所を登録します。
<img width="1000" src="https://user-images.githubusercontent.com/72062153/99924302-0bf99500-2d7d-11eb-9436-06819316b93e.png">
<img width="1000" src="https://user-images.githubusercontent.com/72062153/99924371-6266d380-2d7d-11eb-81da-5362691e96f6.png">

4. 最後に清掃した日から設定した規程日数を超えたものが表示されます。<br>
   掃除が完了したら、「掃除完了」ボタンをクリックしましょう。
<img width="1000" src="https://user-images.githubusercontent.com/72062153/99924734-c0e08180-2d7e-11eb-84e7-f3ab0d58d4aa.png">

5. きれいになった部屋やデスクまわりの画像はアプリ内で共有できます。
<img width="1000" src="https://user-images.githubusercontent.com/72062153/99926061-afe63f00-2d83-11eb-9be3-f66890a5606f.png">


# アプリ開発の背景
コロナ渦をきっかけとして、リモートワークする機会が増えています。それに伴い自宅にいる時間も<br>増えていると予想できます。
普段の職場における労働と比べ、下記2点の傾向が増加していると予想しました。<br>
・一人で部屋にこもりがち。<br>
・仕事とプライベートの切り替えが曖昧。これまで仕事をしない時間帯や場所で仕事をする。<br>

# 設定した問題定義
上記背景から普段の職場に比べ、メンタルヘルスが悪化する可能性があると考えました。<br>
その考えに至った主な理由は下記2点です。<br>
・人との接点が減り、孤独を感じる。<br>
・デスク周りの汚れや整理整頓に対し、他者から指摘されない。部屋が汚く無意識にストレスを感じる。<br>

# 目指した課題解決
上記問題を解決するため、それぞれ下記2つの課題を抽出しました。<br>
・対面に変わる、孤独を感じない仕組みの確立<br>
・清潔が保たれている空間の確保<br>

# 洗い出した要件(課題解決手段)
抽出した上記2つの課題を解決すべく、7つの機能を抽出しました。<br>
※現在(2020年11月時点)⑤までの機能を実装しています。<br>

| **課題**                                                                                 | **課題解決手段**                                                 | **具体的機能**                          |
| ---------------------------------------------------------------------------- | -------------------------------------------------------------- | -------------------------------------- |
| 孤独を感じない仕組みの確立<br>⇨自分のアクションに対して<br>　他者からのリアクションがある | 整理整頓、清掃されたデスクの<br>画像を共有する<br>(自分のアクション)     | ① 画像投稿機能<br>② 投稿画像の一覧表示機能                          |
| ↑                                                                            | 共有した画像にコメントを<br>投稿できる(リアクション)                   | ③ コメント投稿機能                       |
| 清潔が保たれている空間の確保                                                      | 清掃箇所の登録、定期的な提案                                        | ④ 清掃箇所及び関連情報の<br>　登録機能<br>⑤ アルゴリズムの実装、提案機能     |
| ↑                                                                            | 部屋やデスク上の異常<br>(散らかっている状態)を<br>検出する             | ⑥ ラズベリーパイ+カメラ<br>　による監視機能 |
| ↑                                                                            | 検出した異常をアプリへ<br>通知する                                  | ⑦ 異常状態の通知機能                     |

# 実装機能
**掃除登録及び提案機能**<br>
登録した掃除場所情報を元に、最後の清掃した日からの経過日数をアプリ内で計算します。<br>
その経過日数が登録した清掃期間を超えたものを今日の掃除箇所として提案します。<br>
<img width="1000" src="https://user-images.githubusercontent.com/72062153/99951439-77fdec80-2dc1-11eb-8ad8-3e0f3caeb5c6.png">
提案された掃除箇所の「掃除完了」ボタンをクリックすると、該当箇所が非表示になります。<br>
その後一定日数が経過し、再び清掃期間を超えると再度提案されます。<br>
![7df36e989a99008cfb05e428b7614ebb](https://user-images.githubusercontent.com/72062153/100018009-1a988880-2e1f-11eb-9218-deacab494357.gif)

**画像投稿機能**<br>
掃除した箇所の画像投稿及び共有ができます。投稿された画像にはコメントすることもできます。<br>
![1f065ca9bcc8d3637ad3c6370a85436d](https://user-images.githubusercontent.com/72062153/100019758-f5594980-2e21-11eb-9a44-436941a21fa7.gif)

# 実装予定の機能
・ラズベリーパイ及びカメラと連携し、部屋やデスク上の異常(散らかっている状態)検出機能<br>
・検出された異常をアプリへ通知する機能<br>

![image](https://user-images.githubusercontent.com/72062153/100023775-e9bd5100-2e28-11eb-822d-23d826ef713a.png)

# テーブル設計

## users テーブル

| Column            | Type       | Options     |
| ----------------- | ---------- | ----------- |
| email             | string     | null: false |
| encrypted_password| string     | null: false |
| nickname          | string     | null: false |

### Association

- has_many :desks
- has_many :comments
- has_many :suggestions


## desks テーブル

| Column            | Type       | Options     |
| ----------------- | ---------- | ----------- |
| title             | string     | null: false |
| concept           | text       |             |
| user              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments

## comments テーブル

| Column      | Type       | Options           |
|-------------|------------|-------------------|
| text        | text       | null: false       |
| user        | references | foreign_key: true |
| desk        | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :desk

## suggestions テーブル

| Column            | Type       | Options           |
|-------------------|------------|-------------------|
| place             | string     | null: false       |
| status            | boolean    | null: false       |
| period_cleaning   | integer    | null: false       |
| last_cleaned_date | date       | null: false       |
| user              | references | foreign_key: true |

### Association

- belongs_to :user

# 開発環境
Ruby 2.6.5<br>
Ruby on Rails 6.0.3.4<br>
AWS(S3,EC2)/MySQL/Github//Visual Studio Code
