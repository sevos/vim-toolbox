class PluginInstallation < ActiveRecord::Base
  belongs_to :user
  belongs_to :plugin, counter_cache: "installations_count"
  validates :plugin_id, uniqueness: {scope: :user_id}
end
