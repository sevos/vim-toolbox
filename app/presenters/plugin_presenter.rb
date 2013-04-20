class PluginPresenter
  def initialize plugin, link_builder
    @plugin = plugin
    @link_builder = link_builder
  end

  def repository
    @link_builder.link_to @plugin.repository, github_repository_url(repository)
  end

  private

  def github_repository_url(repository)
    "https://github.com/#{repository}"
  end
end
