require 'rails_helper'
require 'support/utilities'

RSpec.describe "Users", type: :request do
  subject { page }
  describe "Signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end
end
