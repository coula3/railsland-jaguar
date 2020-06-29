module UsersHelper
    def user_status
       status = ["active", "inactive", "deactivated"]
    end

    def user_image
        if current_user.image
            img ||= current_user.image
        end
    end

    def user_first_name
        if current_user.first_name && current_user.first_name.include?("-")
            current_user.first_name.gsub("-", " ").split.map {|str| str.capitalize}.join("-") + "'s"
        elsif current_user.first_name
            current_user.first_name.capitalize + "'s"
        else
            "My"
        end
    end

    def is_admin?(user)
        if user.admin
            link_to 'System Users', users_path
        end
    end
end
