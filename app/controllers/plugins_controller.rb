class PluginsController < ApplicationController
  def index
    @plugins = Plugin.all
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

  private

  def plugin_params
    params.require(:plugin).permit(:repository)
  end
end