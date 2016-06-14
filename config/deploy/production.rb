set :stage, :production
server '104.236.252.208', user: 'deploy', roles: %w{web app db}
