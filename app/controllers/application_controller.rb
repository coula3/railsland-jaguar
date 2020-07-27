class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :unauthorized_access_msg, :non_existing_customer_msg, :dealer

    def logged_in?
        !!current_user
    end

    def current_user
        user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def unauthorized_access_msg
        "Access Unauthorized"
    end

    def non_existing_customer_msg
        "Customer does not exist"
    end

    def inactive_user_msg(user)
        user == current_user ? unauthorized_access_msg : "User #{user.full_name} is #{user.status}"
    end

    def dealer
        Dealer.first
    end
end
