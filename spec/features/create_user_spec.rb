require "spec_helper"

describe "Creating a user" do
    it "saves the user information" do
        visit root_url
        click_link "Sign Up"
        expect(current_path).to eq(signup_path)        
        fill_in "Name", with: "Jane Doe"
        fill_in "Email", with: "jane@doe.com"
        fill_in "Password", with: "secret"
        fill_in "Confirm Password", with: "secret"
        click_button "Create Account"
        expect(current_path).to eq(user_path(User.last))
        expect(page).to have_text("Jane Doe")
    end
end