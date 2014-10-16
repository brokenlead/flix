require 'spec_helper'

describe 'Signing in' do
    it 'prompts for an email and password' do
        visit root_url
        click_link 'Sign Up'
        expect(current_path).to eq(signup_path)
        expect(page).to have_field('Email')
        expect(page).to have_field('Password')
    end
end