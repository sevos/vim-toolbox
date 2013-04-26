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
end
