class User < ActiveRecord::Base
  has_many :plugin_installations
  has_many :plugins, :through => :plugin_installations, uniq: true

  scope :by_auth, ->(provider, uid) { where(provider: provider, uid: uid) }

  validates *%i(nickname email provider uid), presence: true
  validates :uid, uniqueness: {:scope => :provider}
end
