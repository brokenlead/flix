require 'spec_helper'

describe 'Viewing the list of users' do
    it 'shows the list of users' do
        user1 = User.create!(user_attributes(name:'user1', username:'user1', email:'user1@test.com'))
        user2 = User.create!(user_attributes(name:'user2', username:'user2', email:'user2@test.com'))
        user3 = User.create!(user_attributes(name:'user3', username:'user3', email:'user3@test.com'))
        sign_in(user1)
        visit users_url
        expect(page).to have_link(user1.name)
        expect(page).to have_link(user2.name)
        expect(page).to have_link(user3.name)
    end
end