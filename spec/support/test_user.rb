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
    def open_admin_plugin_list
      visit '/admin/plugins'
    end

    def approve_plugin repo
      open_admin_plugin_list

      within(".plugin", text: repo) do
        click_button "Approve"
      end
    end

    def does_not_see_plugin repository
      open_admin_plugin_list
      not_see! repository
    end
  end

  module PluginViewer
    def see_plugin repository
      open_plugin_list
      see! repository
    end

    def does_not_see_plugin repository
      open_plugin_list
      not_see! repository
    end
  end
end
