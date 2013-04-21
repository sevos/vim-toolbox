class User < ActiveRecord::Base
  scope :by_auth, ->(provider,uid) { where(provider: provider, uid: uid) }
end
