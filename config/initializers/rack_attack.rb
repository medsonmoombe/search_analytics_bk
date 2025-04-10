require 'rack/attack'

class Rack::Attack
    throttle('search/ip', limit: 60, period: 1.minute) do |req|
      req.ip if req.path == '/search/track' && req.post?
    end
  end