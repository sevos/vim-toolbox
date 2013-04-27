class User < ActiveRecord::Base
  has_many :plugin_installations
  has_many :plugins, :through => :plugin_installations

  scope :by_auth, ->(provider,uid) { where(provider: provider, uid: uid) }
end
