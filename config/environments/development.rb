# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

# Twitter oAuth parameters
OAUTH_TWITTER_KEY           = "ytopIVv10emwV4PK3ROoKw"
OAUTH_TWITTER_SECRET        = "MFq1Olzi2i9q9ni4grmLA2ZtIast3x9931T1XMsQ"
OAUTH_TWITTER_REQUEST_TOKEN = "http://twitter.com/oauth/request_token"
OAUTH_TWITTER_ACCESS_TOKEN  = "http://twitter.com/oauth/access_token"
OAUTH_TWITTER_AUTHORIZE_URL = "http://twitter.com/oauth/authorize"
