set :user, 'itakeshi'
set :domain, 'igem.itakeshi.net'
set :port, '11122'
set :application, 'bbri'

set :ssh_options, port: '11122'
set :repository, "ssh://#{user}@#{domain}:#{port}/home/#{user}/git/#{application}.git"
set :deploy_to, "/var/app/rails/#{application}"

set :scm, :git

role :web, domain                   # Your HTTP server, Apache/etc
role :app, domain                   # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end


set :deploy_via, :remote_cache
set :branch, 'development'
set :scm_verbose, true
set :use_sudo, false
set :rails_env, :production

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

namespace :deploy do
  desc "cause Passenger to initiate a restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

require 'bundler/capistrano'
