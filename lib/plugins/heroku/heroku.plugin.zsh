# Heroku plugin
#
# A tool for managing continuous deployment from Travis to Heroku, as
# well as managing your Heroku apps via the CLI.

# Load Heroku config
source ~/.dots/config/heroku.zsh

# Secure your API key on Travis, so it can be uploaded to CI and
# used to deploy your Heroku app.
function secure_api_key() {
  travis encrypt $1 HEROKU_API_KEY=$HEROKU_API_KEY
}
