require "spec_helper"

describe "Viewing a user" do

    it "shows the user information" do
        user = User.create!(user_attributes)
        sign_in(user)
        visit user_url(user)
        expect(page).to have_text(user.name)
        expect(page).to have_text(user.email)
        expect(page).to have_text("Member since")
    end

end