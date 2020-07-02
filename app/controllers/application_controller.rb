class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :access_unauthorized_msg

    def logged_in?
        !!current_user
    end

    def current_user
        user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def access_unauthorized_msg
        "Access Unauthorized"
    end
end
