class ApplicationController < ActionController::Base
    helper_method :currrent_user

    private
    def currrent_user
        @current_user || = User.find_by(id: session[:user_id]) if session[:user_id]
    end
end
