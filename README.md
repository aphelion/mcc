# MCC

[![Circle CI](https://circleci.com/gh/aphelion/mcc.svg?style=svg)](https://circleci.com/gh/aphelion/mcc)

## Heroku Configuration

Add Redis

```
heroku addons:create heroku-redis:hobby-dev
```

Add config vars

```
heroku config:add ACTION_CABLE_URL='wss://YOUR_DOMAIN/cable'
heroku config:add 'ACTION_CABLE_ALLOWED_REQUEST_ORIGINS=["http://YOUR_DOMAIN"]'
```
