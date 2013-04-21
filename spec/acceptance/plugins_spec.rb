require 'spec_helper'

feature "plugins" do
  let(:adam) { TestUser.new }
  let(:artur) { TestUser.new }
  let(:github) { TestUser.new.tap{ |u| u.roles(:github) } }

  scenario "submit and approve new plugin" do
    artur.roles(:plugin_reviewer)
    adam.roles(:plugin_submitter, :plugin_viewer)

    adam.submit_plugin "user/superplugin"
    adam.does_not_see_plugin "user/superplugin"

    artur.approve_plugin "user/superplugin"
    artur.does_not_see_plugin 'user/superplugin'

    adam.open_plugin_list
    adam.see_plugin 'user/superplugin'
  end
end
