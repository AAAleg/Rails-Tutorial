require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "Static pages" do
    let(:base_title){"Ruby on Rails Tutorial Sample App"}
    describe "Home page" do
      before{ visit '/static_pages/home' }
      it "should have the content 'Sample App'" do
        expect(page).to have_content('Sample App')
      end
      it "should have the base title" do
        expect(page).to have_title(base_title)
      end
      it "should not have a custom page title" do
        expect(page).not_to have_title("| Home")
      end
    end
    describe "Help page" do
      before { visit '/static_pages/help' }
      it "should have the content 'Help'" do
        expect(page).to have_content('Help')
      end
      it "should have the right title" do
        expect(page).to have_title("#{base_title} | Help")
      end
    end
    describe "About page" do
      before { visit '/static_pages/about' }
      it "should have the content 'About Us'" do
        expect(page).to have_content('About Us')
      end
      it "should have the right title" do
        expect(page).to have_title("#{base_title} | About Us")
      end
    end
    describe "Contacts page" do
      before { visit '/static_pages/contact' }
      it "should have the content 'Contact'" do
        expect(page).to have_content('Contact')
      end
      it "should have the right title" do
        expect(page).to have_title("#{base_title} | Contact")
      end
    end
  end
end
