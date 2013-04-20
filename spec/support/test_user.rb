require 'bbq/test_user'

class TestUser < Bbq::TestUser
  def open_plugin_list
    visit '/'
    click_link "Plugins"
  end

  module PluginSubmitter
    def submit_plugin repo
      open_plugin_list

      click_link "Submit plugin"

      fill_in "Github repository", with: repo
      click_button "Submit"
    end
  end

  module PluginReviewer
    def approve_plugin repo
      visit '/admin/plugins'

      within(".plugin", text: repo) do
        click_button "Approve"
      end
    end
  end
end
