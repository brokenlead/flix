require "spec_helper"

describe "Deleting a user" do
    it "removes the user from the list" do
        user = User.create!(user_attributes)
        sign_in(user)
        visit user_path(user)
        click_link "Delete"
        expect(current_path).to eq(root_path)
        expect(page).not_to have_text(user.name)
        expect(page).to have_link('Sign In')
        expect(page).not_to have_link('Sign Out')
    end
end