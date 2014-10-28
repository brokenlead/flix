require "spec_helper"

describe "Deleting a user" do
    it "does NOT remove the user from the list when the signed in user is not an admin" do
        user = User.create!(user_attributes)
        sign_in(user)
        visit user_path(user)
        expect(page).not_to have_link('Delete')
    end
    it "removes the user from the list when the signed in user is an admin" do
        user = User.create!(user_attributes(admin: true))
        sign_in(user)
        visit user_path(user)
        click_link "Delete"
        expect(current_path).to eq(root_path)
        expect(page).not_to have_text(user.name)
        expect(page).to have_link('Sign In')
        expect(page).not_to have_link('Sign Out')
    end
end