# Allow all local traffic
Rack::Attack.safelist('allow-localhost') { |req| req.ip == '127.0.0.1' || req.ip == '::1' }

# Allow an IP address to make 10 requests every 1 seconds
Rack::Attack.throttle('req/ip', limit: 10, period: 1, &:ip)
