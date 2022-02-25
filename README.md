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