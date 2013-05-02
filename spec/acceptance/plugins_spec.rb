require 'spec_helper'

feature "plugins" do
  let(:adam) { TestUser.new }
  let(:artur) { TestUser.new }
  let(:github) { TestGithub.new }

  scenario "adding new plugin" do
    artur.roles(:plugin_reviewer)
    adam.roles(:plugin_submitter, :plugin_viewer)

    adam.submit_plugin "user/superplugin"
    adam.does_not_see_plugin "user/superplugin"

    github.has_repository "user/superplugin", with_description: "Codes for you"
    artur.approve_plugin "user/superplugin"
    artur.does_not_see_plugin 'user/superplugin'
    adam.see_plugin 'user/superplugin', with_description: "Codes for you"
  end

  scenario "rejecting plugin" do
    artur.roles(:plugin_reviewer)
    adam.roles(:plugin_submitter, :plugin_viewer)

    adam.submit_plugin "user/superplugin"
    artur.reject_plugin "user/superplugin"
    artur.does_not_see_plugin 'user/superplugin'
    adam.does_not_see_plugin "user/superplugin"
  end

  scenario "displaying admin page as logged in github user" do
    adam.roles(:github_user, :plugin_reviewer)
    adam.sign_in
    adam.open_admin_plugin_list
  end

  scenario "ordering plugins: installations_count DESC, approved_at DESC" do
    @plugin_a = Plugin.create!(repository: "test/a", approved_at: 1.day.ago)
    @plugin_b = Plugin.create!(repository: "test/b", approved_at: 2.days.ago)
    @plugin_c = Plugin.create!(repository: "test/c", approved_at: 3.days.ago)

    artur.roles(:plugin_viewer, :vim_user, :github_user)
    artur.sign_in
    artur.install_plugin "test/c"
    artur.see_plugin_list %w(test/c test/a test/b)
  end
end
