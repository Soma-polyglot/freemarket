# DB設計


## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|last_name_kanzi|string|null: false|
|first_name_kanzi|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|phone_number|integer|null: false, unique: true|
|birthday|date|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|adress|string|null: false|
|building|string|
|telephone_number|integer|
|profile|text|
|image|text|

### Association
- has_many :products
- has_many :comments
- has_many :likes
- has_one :credits


## creditsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|number|integer|null: false, unique: true|
|expiration_date|date|null: false|
|security_code|integer|null: false|

### Association
- has_one :user


## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|product_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|product_id|references|null: false, foreign_key: true|
|text|text

### Association
- belongs_to :user
- belongs_to :product


## productsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|name|string|null: false|
|description|text|null: false|
|category_id|references|null: false, foreign_key: true|
|size|string|null: false|
|brand_id|references|null: false, foreign_key: true|
|status|string|null: false|
|fee|integer|null: false|
|area|string|null: false|
|date|string|null: false|
|price|integer|null: false|

### Association
- has_many :likes
- has_many :comments
- has_many :product_images
- belongs_to :user
- belongs_to :category
- belongs_to :brand


## product_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|references|null: false, foreign_key: true|
|image|text|null: false|

### Association
- belongs_to :product


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|references|null: false, foreign_key: true|
|name|string|null: false|
|ancestry|integer|

### Association
- has_many :products


## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|references|null: false, foreign_key: true|
|name|string|

### Association
- has_many :products
