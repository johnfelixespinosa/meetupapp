class ApplicationController < ActionController::Base
  before_action :authenticate_user, except: [:new, :create]

  def success
    render succe
  end

  private

    def authenticate_user
      client_id = ENV['MEETUP_CONSUMER_KEY']
      redirect_uri = CGI.escape("http://localhost:3000/auth")
      meetup_url = "https://secure.meetup.com/oauth2/authorize?client_id=#{client_id}&response_type=code&redirect_uri=#{redirect_uri}"
      redirect_to meetup_url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end

# https://api.meetup.com/oauth/request/
# ?client_id=YOUR_CLIENT_ID

# https://secure.meetup.com/oauth2/authorize
# ?client_id=YOUR_CONSUMER_KEY
# &response_type=code
# &redirect_uri=YOUR_CONSUMER_REDIRECT_URI