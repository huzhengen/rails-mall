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