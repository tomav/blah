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
OAUTH_TWITTER_KEY             = "ytopIVv10emwV4PK3ROoKw"
OAUTH_TWITTER_SECRET          = "MFq1Olzi2i9q9ni4grmLA2ZtIast3x9931T1XMsQ"
OAUTH_TWITTER_URL             = "http://twitter.com"

# Facebook oAuth parameters
OAUTH_FACEBOOK_KEY            = "126118037429328"
OAUTH_FACEBOOK_SECRET         = "75d01b73f3b2a3f1aa5e43f12833d4b3"
OAUTH_FACEBOOK_URL            = "https://graph.facebook.com"
