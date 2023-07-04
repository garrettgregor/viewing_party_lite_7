require "rails_helper"

RSpec.describe "/", type: :feature do
  describe "landing page" do
    before(:each) do
      visit "/"
    end

    let!(:user_1) { User.create!(name: "Michael", email: "mcalla123@gmail.com") }
    let!(:user_2) { User.create!(name: "Garrett", email: "garrett123@gmail.com") }
    let!(:user_3) { User.create!(name: "Justin", email: "justin123@gmail.com") }

    it "displays the application title" do
      expect(current_path).to eq("/")

      expect(page).to have_content("Viewing Party")
    end

    it "displays a button to create a new user" do
      expect(current_path).to eq("/")

      expect(page).to have_button("Create New User", href: "/register")
    end

    it "displays a list of existing users, that links to the users dashboard" do
      expect(current_path).to eq("/")

      within ".existing_users" do
        expect(page).to have_link("#{user_1.email}", href: user_path(user_1))
        expect(page).to have_link("#{user_2.email}", href: user_path(user_2))
        expect(page).to have_link("#{user_3.email}", href: user_path(user_3))
      end
    end

    it "displays a link to go back to the landing page" do
      expect(current_path).to eq("/")

      expect(page).to have_link("Home", href: "/")
    end
  end
end