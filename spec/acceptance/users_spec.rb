require 'spec_helper'

feature "users" do
  scenario "sign in and out via github" do
    adam = TestUser.new
    adam.roles(:github_user)

    adam.sign_in as: "adam"
    adam.is_signed_in
    adam.sign_out
  end

  scenario "sign in second time to the same account (bug #4)" do
    adam = TestUser.new
    adam.roles(:github_user)

    adam.sign_in
    adam.sign_out
    adam.sign_in

    expect(User.count).to eq(1)
  end
end

