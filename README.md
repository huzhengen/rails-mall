初始化项目
```
rails _5.2.6_ new rails-mall --skip-bundle -d mysql
```

```
rails g sorcery:install
rails generate sorcery:install user_activation reset_password  remember_me --only-submodules
```

创建首页 controller
```
rails g controller welcome index
```

```
rails g mailer user
```

Category Product
```
rails g model category
rails g model product
```

ancestry
```
rails g migration add_ancestry_to_category ancestry:string
```

Controller admin::sessions admin::categories
```
rails d controller admin::sessions new
rails g controller admin::sessions new
rails g controller admin::categories index new
```

图片 model
```
rails g model product_image
```

给 product_images 添加索引
```
rails g migration add_product_images_index
```

购物车 model
```
rails g model shopping_cart
```

给 user 添加 column
```
rails g migration add_user_uuid_column
```

地址 model
```
rails g model address
rails g migration add_user_default_address_id
```

订单 model
```
rails g model order
```

支付 model
```
rails g model payment
rails g migration add_order_payment_id_column
```

给 users 添加 cellphone
```
rails g migration add_users_cellphone
```

手机验证码
```
rails g model verify_token
```

给 users 添加 is_admin 字段
```
rails g migration add_users_is_admin_column
```

给 products 添加 image_url 字段
```
rails g migration add_products_image_url_column 
```