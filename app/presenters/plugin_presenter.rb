class PluginPresenter < SimpleDelegator
  def initialize plugin, link_builder
    super plugin
    @plugin = plugin
    @link_builder = link_builder
  end

  def repository
    @link_builder.link_to(@plugin.repository,
                          github_repository_url(@plugin.repository),
                          target: "_blank")
  end

  def description
    super.presence || "No description"
  end

  def add_to_toolbox_button
    @link_builder.link_to("(#{installations_count}) >",
                          install_plugin_path,
                          class: "add", method: "post")
  end

  private

  def github_repository_url(repository)
    "https://github.com/#{repository}"
  end

  def install_plugin_path
    @link_builder.install_plugin_path(self)
  end
end
