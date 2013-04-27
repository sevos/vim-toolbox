require 'bbq/test_user'

class TestUser < Bbq::TestUser
  def open_plugin_list
    visit '/'
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

    def reject_plugin repo
      open_admin_plugin_list

      within(".plugin", text: repo) do
        click_button "Reject"
      end
    end

    def does_not_see_plugin repository
      open_admin_plugin_list
      not_see! repository
    end
  end

  module PluginViewer
    def see_plugin(repository, with_description: nil,
                   has_been_added_to_toolboxes: nil)
      open_plugin_list
      see! repository
      see! with_description if with_description
      if has_been_added_to_toolboxes
        within(".plugin", text: repository) do
          expect(page).to have_content "(#{has_been_added_to_toolboxes}) >"
        end
      end
    end

    def does_not_see_plugin repository
      open_plugin_list
      not_see! repository
    end

    def add_to_toolbox repository
      within(".plugin", text: repository) do
        find(".add").click
      end
    end

    def added_to_toolbox repository
      within("#toolbox") do
        expect(page).to have_content(repository)
      end
    end
  end

  module GithubUser
    def sign_in(as: "test_user")
      open_plugin_list

      authorization = if as.respond_to? :authorize
        as.authorize
      else
        TestGithub.new(nickname: as.to_s).authorize
      end

      click_link "Sign in"
      @logged_in_user_name = authorization.nickname
      authorization
    end

    def is_signed_in
      not_see! "Sign in"
      expect(page).to have_content(@logged_in_user_name)
    end

    def sign_out
      open_plugin_list
      click_link "Sign out"
    end
  end
end
