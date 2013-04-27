require 'spec_helper'

feature "toolbox" do
  let(:adam) { TestUser.new }
  let(:paul) { TestUser.new }

  background do
    @repository = "test/repository"
    @plugin = Plugin.create!(repository: @repository,
                             approved_at: 1.week.ago)
  end

  scenario "install plugin" do
    adam.roles(:plugin_viewer, :github_user)
    adam.sign_in as: "adam"
    adam.see_plugin @repository, has_been_added_to_toolboxes: 0
    adam.add_to_toolbox @repository
    adam.see_plugin @repository, has_been_added_to_toolboxes: 1
    adam.added_to_toolbox @repository

    paul.roles(:plugin_viewer, :github_user)
    paul.sign_in as: "paul"
    paul.add_to_toolbox @repository
    adam.see_plugin @repository, has_been_added_to_toolboxes: 2
  end

  scenario "cannot install a plugin twice" do
    adam.roles(:plugin_viewer, :github_user)
    adam.sign_in
    adam.add_to_toolbox @repository
    adam.cannot_add_plugin @repository
  end
end
