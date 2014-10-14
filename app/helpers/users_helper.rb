module UsersHelper
    def format_member_since(user)
        user.created_at.to_s(:month_and_year)
    end
end
