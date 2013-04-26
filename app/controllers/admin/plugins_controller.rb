class Admin::PluginsController < ApplicationController
  if ENV['ADMIN_PASSWORD']
    http_basic_authenticate_with name: "admin", password: ENV["ADMIN_PASSWORD"]
  end

  def index
    @plugins = Plugin.waiting.map { |plugin| PluginPresenter.new(plugin, view_context) }
  end

  def approve
    plugin = Plugin.find(params[:id])
    plugin.approve
    plugin.sync
    redirect_to admin_plugins_path
  end
end
