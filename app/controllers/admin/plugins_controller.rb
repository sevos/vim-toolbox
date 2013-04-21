class Admin::PluginsController < ApplicationController
  def index
    @plugins = Plugin.waiting.map { |plugin| PluginPresenter.new(plugin, view_context) }
  end

  def approve
    plugin = Plugin.find(params[:id])
    plugin.approve
    redirect_to admin_plugins_path
  end
end
