require 'spec_helper'

feature "users" do
  scenario "sign in and out via github" do
    adam = TestUser.new
    adam.roles(:github_user)

    adam.sign_in as: "adam"
    adam.is_signed_in
    adam.sign_out
  end
end

