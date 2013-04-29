require 'spec_helper'

feature "toolbox" do
  let(:adam) { TestUser.new }
  let(:paul) { TestUser.new }

  background do
    @repository = "test/repository"
    @plugin = Plugin.create!(repository: @repository,
                             approved_at: 1.week.ago)
    adam.roles(:plugin_viewer, :github_user)
    paul.roles(:plugin_viewer, :github_user)
  end

  scenario "install plugin" do
    adam.sign_in as: "adam"
    adam.see_plugin @repository, has_been_added_to_toolboxes: 0
    adam.install_plugin @repository
    adam.see_plugin @repository, has_been_added_to_toolboxes: 1
    adam.has_in_toolbox @repository

    paul.sign_in as: "paul"
    paul.install_plugin @repository
    adam.see_plugin @repository, has_been_added_to_toolboxes: 2
  end

  scenario "cannot install a plugin twice" do
    adam.sign_in
    adam.install_plugin @repository
    adam.cannot_add_plugin @repository
  end

  scenario "uninstall plugin" do
    adam.sign_in
    adam.install_plugin @repository
    adam.uninstall_plugin @repository
    adam.has_not_in_toolbox @repository
    adam.see_plugin @repository, has_been_added_to_toolboxes: 0
  end

  scenario "downloading toolbox" do
    adam.roles(:vim_user)
    adam.sign_in
    adam.install_plugin @repository

    adam_id = adam.db_user.id

    installer_sh = adam.download_installer_sh
    expect(installer_sh).to include("curl -s http://www.example.com/toolboxes/#{adam_id}.vim > ~/.toolbox.vim")

    toolbox_vim = adam.download_toolbox_vim(installer_sh)

    expect(toolbox_vim).to include("Bundle \"#{@repository}\"")
  end
end
