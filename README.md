# rails-training

Ruby on Rails Getting Started.

### Install Rails

`gem install rails`

### Create Rails Application

`rails new blog`

# Develop on Existing Project

### Install Javascript Dependencies

`yarn install`

### Install Gems and Rails Dependencies

`bundle install`

### Make migrations

`rails db:migrate`

### Run Server and play with Rails!

`rails server`

----------------------------
**SOURCE:**
[Development Installation](https://guides.rubyonrails.org/development_dependencies_install.html)

# Deploy to Heroku

This steps are a summary to deploy Rails app to Heroku.

### Upgrade Rails app
If we have a previous Rails app created we need to add the respective gem, because Heroku does not support `sqlite3`

In `Gemfile` add:
```
gem `pg`
```
and install the new gem inside the project with:
```
bundle install
```
Change database adaptor and databases names in `config/database.yml`
```ruby
  # ...
  adapter: postgresql
  # ...
  development:
    <<: *default
    database: database_development
  # ...
  test:
    <<: *default
    database: database_test
  # ...
  production:
    <<: *default
    database: database_production
    username: user
    password: password
  #...(Shorcut to skip lines)
```
Finally run in terminal:
```
rails db:create
rails db:migrate
```
**Enviroment Configuration Ruby**
Add next code to `config/environments/production.rb`

```ruby
config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

if ENV["RAILS_LOG_TO_STDOUT"].present?
  logger           = ActiveSupport::Logger.new(STDOUT)
  logger.formatter = config.log_formatter
  config.logger = ActiveSupport::TaggedLogging.new(logger)
end
```
### Deploy App Heroku
To made possible this step we should start a git repository. And we need to have installed [heroku-cli](https://devcenter.heroku.com/articles/heroku-cli#download-and-install).

In the project directory type:
```
heroku create
```
**Add Build Pack for Ruby**
This help us to install Ruby Dependencies and Gems
```
heroku buildpacks:set heroku/ruby
```

Then we need to push local repository to Heroku:
```
git push heroku main
```

**Create and Migrate Database on Heroku App**
This line creates a database with the hooby-dev plan:
```
heroku addons:create heroku-postgresql:hobby-dev
```
Finally we need to migrate database on heroku app:
```
heroku run rake db:migrate
```

### Create Heroku Procfile
In root path of project we need to add a `Procfile` and write:
```
web: bundle exec puma -C config/puma.rb
```
or
```
web: rails server
```

This file works with `puma.rb` file, for maximun performance visit [Heroku Puma documentation](https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#adding-puma-to-your-application)

### Run Heroku locally
Procfile can be used locally, we need to add some `.env`variables with:
```
echo "RACK_ENV=development" >>.env
echo "PORT=3000" >> .env
```
Do not forget to add this file to `.gitignore`.

Now we can run heroku:
```
heroku local
```
Commit new changes and push to heroku app:
```
git push heroku main
```
If we need to push changes from another branch use:
```
git push heroku branch_name:main
```

### Additional Settings
Maybe Yarn packages will fail in deploy, so i recomend use the next Config var:
```
heroku config:set YARN_PRODUCTION=false
```
This will access to `devDependencies` in our `package.json`
[Skip Pruning](https://devcenter.heroku.com/articles/nodejs-support#skip-pruning)

### Visit your App
In my case the app was deployed in the next URL:

https://sangeekyonrails.herokuapp.com/

---------------------------------------
**Sources:**
- [Getting started with Rails](https://devcenter.heroku.com/articles/getting-started-with-ruby)
- [Postgres Database in Heroku](https://devcenter.heroku.com/articles/heroku-postgresql#provisioning-heroku-postgres)
- [Heroku Puma documentation](https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#adding-puma-to-your-application)
