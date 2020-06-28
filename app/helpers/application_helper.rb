module ApplicationHelper
    def delete_confirmation_msg
        msg = "Do you want to continue with delete?"
    end

    def full_name(user)
        ["#{user.first_name}", "#{user.last_name}"].join(" ")
    end
end
