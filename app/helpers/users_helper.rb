module UsersHelper
    def format_member_since(user)
        user.created_at.to_s(:month_and_year)
    end
    def profile_image_for(user)
        image_tag("http://secure.gravatar.com/avatar/#{user.gravatar_id}", alt: user.name)
    end
end
