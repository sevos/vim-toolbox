require 'spec_helper'

feature "toolbox" do
  let(:adam) { TestUser.new }
  let(:paul) { TestUser.new }

  scenario "add to toolbox" do
    plugin = Plugin.create!(repository: "test/repository",
                            approved_at: 1.week.ago)

    adam.roles(:plugin_viewer, :github_user)
    adam.sign_in
    adam.add_to_toolbox "test/repository"
    adam.see_plugin "test/repository", has_been_added_to_toolboxes: 1
    adam.added_to_toolbox "test/repository"

    paul.sign_in
    paul.add_to_toolbox "test/repository"
    adam.see_plugin "test/repository", has_been_added_to_toolboxes: 2
  end

end
