module UsersHelper
    def format_member_since(user)
        user.created_at.to_s(:month_and_year)
    end
    def profile_image_for(user, options={})
        size = options[:size] || 80
        url = "http://secure.gravatar.com/avatar/#{user.gravatar_id}?s=#{size}"
        image_tag(url, alt: user.name)
    end
end
