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