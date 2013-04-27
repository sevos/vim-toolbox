class PluginPresenter < SimpleDelegator
  def initialize plugin, view_context
    super plugin
    @plugin = plugin
    @view_context = view_context
  end

  def repository
    @view_context.link_to(@plugin.repository,
                          github_repository_url(@plugin.repository),
                          target: "_blank")
  end

  def description
    super.presence || "No description"
  end

  def add_to_toolbox_button
    if toolbox && toolbox.include?(@plugin)
      installations_count
    else
      @view_context.link_to("#{installations_count} >",
                            install_plugin_path,
                              class: "add", method: "post")
    end
  end

  private

  def installations_count
    "(#{super})"
  end

  def toolbox
    @view_context.toolbox
  end

  def github_repository_url(repository)
    "https://github.com/#{repository}"
  end

  def install_plugin_path
    @view_context.install_plugin_path(self)
  end
end
