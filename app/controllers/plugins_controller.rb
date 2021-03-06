class PluginsController < ApplicationController
  before_filter :require_login, only: [:install, :uninstall]

  def index
    @plugins = Plugin.approved.recommended_order.map { |p| PluginPresenter.new(p, view_context) }
  end

  def new
    @plugin = Plugin.new
  end

  def create
    @plugin = Plugin.new(plugin_params)
    if @plugin.save
      redirect_to plugins_path
    else
      render :new
    end
  end

  def install
    plugin = Plugin.find(params[:id])
    toolbox.install(plugin)
    redirect_to plugins_path
  end

  def uninstall
    plugin = Plugin.find(params[:id])
    toolbox.uninstall(plugin)
    redirect_to plugins_path
  end

  private

  def plugin_params
    params.require(:plugin).permit(:repository)
  end
end
