set :application, 'partiu'
set :repo_url, 'git@github.com:mdsgpp2016/backend.git'
set :ssh_options, { forward_agent: true }
set :branch, ENV['BRANCH'] if ENV['BRANCH']
set :rvm_ruby_version, '2.3.1@partiu'

namespace :deploy do
  after :publishing, :'passenger:restart'
end
