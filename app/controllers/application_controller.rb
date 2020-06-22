class ApplicationController < ActionController::Base
    def current_user
        @user ||= User.find_by(id: session[:id]) if session[:id]
    end
end
