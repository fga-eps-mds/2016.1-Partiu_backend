set :application, 'partiu'
set :repo_url, 'git@github.com:mdsgpp2016/backend.git'
set :branch, ENV['BRANCH'] if ENV['BRANCH']
set :rvm_ruby_version, '2.3.1@partiu'
set :ssh_options, keys: ["config/deploy_id_rsa"] if File.exist?("config/deploy_id_rsa")
set :bundle_without, [:development, :test]

namespace :deploy do
  after :publishing, :'passenger:restart'
end
