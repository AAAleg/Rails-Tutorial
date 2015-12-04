require 'rails_helper'
require 'support/utilities'

RSpec.describe "Users", type: :request do
  subject { page }

  describe "Signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }

    let(:submit){ "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "example@test.ru"
        fill_in "Password", with: "master"
        fill_in "Confirmation", with: "master"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count)
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end
end
