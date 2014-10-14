require "spec_helper"

describe "Deleting a movie" do
    it "removes the user from the list" do
        user = User.create!(user_attributes)
        visit user_path(user)
        click_link "Delete"
        expect(current_path).to eq(users_path)
        expect(page).not_to have_text(user.name)
    end
end