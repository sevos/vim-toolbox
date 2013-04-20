class Admin::PluginsController < ApplicationController
  def index
    @plugins = Plugin.all.map { |plugin| PluginPresenter.new(plugin, view_context) }
  end

  def approve
  end
end
