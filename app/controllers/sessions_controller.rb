class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    data = {
      client_id: ENV['MEETUP_CONSUMER_KEY'],
      client_secret: ENV['MEETUP_SECRET'],
      grant_type: 'authorization_code',
      redirect_uri: 'http://localhost:3000/auth',
      code: params[:code]
    }

    resp = Faraday.post("https://secure.meetup.com/oauth2/access") do |req|
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.body = URI.encode_www_form(data)
      # req.params['client_id'] = ENV['MEETUP_CONSUMER_KEY']
      # req.params['&client_secret'] = ENV['MEETUP_SECRET']
      # req.params['&grant_type'] = 'authorization_code'
      # req.params['&redirect_uri'] = 'http://localhost:3000/auth'
      # req.params['&code'] = [:code]
    end


    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    puts "#" * 90
    puts resp.body
    puts "#" * 90


    redirect_to meetups_path
  end
end
