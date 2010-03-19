# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fedora_collab_session',
  :secret      => '70e7335570e1ace0974e0cff9318fcb03cbfe80e3fdec57dc33b4dd5b2379311c952f34109e8bcdc5b5fa454a7a82ea5fe16ed42f4dd6679581025707e5579e7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
