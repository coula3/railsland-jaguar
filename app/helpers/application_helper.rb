module ApplicationHelper
    def delete_confirmation_msg
        msg = "Do you want to continue with delete?"
    end

    def full_name(user)
        ["#{user.first_name}", "#{user.last_name}"].join(" ")
    end

    def last_name_first_name(user)
        ["#{user.last_name.upcase},", "#{user.first_name}"].join(" ")
    end

    def readable_created_at(object)
        object.created_at.strftime("%b %d, %Y")
    end

    def user_workspace
        link_to 'My Workspace', user_workspace_path
    end

    def pad_index(index)
        if index < 10
            "00" + index.to_s
        elsif index >= 10 && index < 100
            "0" + index.to_s
        else
            index
        end
    end
end
