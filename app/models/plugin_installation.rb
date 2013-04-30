class PluginInstallation < ActiveRecord::Base
  belongs_to :user
  belongs_to :plugin
  validates :plugin_id, uniqueness: {scope: :user_id}
end
