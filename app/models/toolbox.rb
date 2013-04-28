class Toolbox

  def self.for(user)
    user && Toolbox.new(user)
  end

  def initialize(user)
    @user = user
  end

  def install(plugin)
    @user.plugins << plugin
  end

  def uninstall(plugin)
    @user.plugins.delete(plugin)
  end

  def to_partial_path
    "toolbox"
  end

  delegate :plugins, to: :@user
  delegate :include?, to: :plugins
end
