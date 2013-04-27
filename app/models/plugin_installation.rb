class PluginInstallation < ActiveRecord::Base
  belongs_to :user
  belongs_to :plugin
end
