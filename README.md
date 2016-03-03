# MCC

## Heroku Configuration

Configure Heroku to run migrations on every deploy.

```
heroku buildpacks:set https://github.com/heroku/heroku-buildpack-ruby
heroku buildpacks:add https://github.com/gunpowderlabs/buildpack-ruby-rake-deploy-tasks
heroku config:set DEPLOY_TASKS='db:migrate cache:clear'
```
