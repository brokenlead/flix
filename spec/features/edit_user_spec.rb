require "spec_helper"

describe "Editing a user" do
    it "updates the user account" do
        user = User.create!(user_attributes)
        visit user_url(user)
        click_link "Edit"
        expect(current_path).to eq(edit_user_path(user))
        expect(find_field("Name").value).to eq(user.name)
        fill_in "Name", with: "Joe Tester"
        click_button "Update Account"
        expect(current_path).to eq(user_path(user))
        expect(page).to have_text("Joe Tester")
    end

    it "does not update the user account if there is an error" do
        user = User.create!(user_attributes)
        visit edit_user_url(user)
        fill_in "Name", with: ""
        click_button "Update Account"
        expect(page).to have_text("error")
    end
end