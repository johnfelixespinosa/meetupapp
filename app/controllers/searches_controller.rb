class SearchesController < ApplicationController
  def search
  end

  def meetups
    resp = Faraday.get("https://api.meetup.com/2/member/self/groups") do |req|
      req.params['oauth_token'] = session[:token]
      # don't forget that pesky v param for versioning
      # req.params['v'] = '20160201'
    end
    @groups = JSON.parse(resp.body)["response"]["groups"]
  end
end

