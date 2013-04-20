require 'spec_helper'

feature "plugins" do
  let(:adam) { TestUser.new }
  let(:github) { TestUser.new.tap{ |u| u.roles(:github) } }

  scenario "submit new plugin" do
    adam.roles(:plugin_submitter)

    adam.submit_plugin "user/superplugin"

    adam.open_plugin_list
    adam.see! "user/superplugin"
  end
end
