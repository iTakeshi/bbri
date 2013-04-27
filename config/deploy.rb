puts "\n\e[0;31m Are you sure? \e[0m\n"
proceed = STDIN.gets[0..0] rescue nil
exit unless proceed == 'y' || proceed == 'Y'

ssh_options[:forward_agent] = true
ssh_options[:port] = '10022'
default_run_options[:pty] = true

set :scm,         :git
set :repository,  'git@github.com:iTakeshi/bbri.git'
set :application, 'bbreview'

set :deploy_via,  :remote_cache
set :scm_verbose, true
set :use_sudo,    false
set :rails_env,   :production

set :user,   'itakeshi'
set :domain, 'www.bbreview.net'
set :port,   '10022'
set :branch, 'master'

set :deploy_to, "/var/app/#{application}"
role :web, domain                   # Your HTTP server, Apache/etc
role :app, domain                   # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

require 'bundler/capistrano'

load 'deploy/assets'

task :setup_shared_dirs, :roles => :app do
  run "#{try_sudo} mkdir -p -m 755 #{shared_path}/config"
  run "#{try_sudo} mkdir -p -m 755 #{shared_path}/config/initializers"
  puts "\n\e[0;31m NOTE! \e[0m\n"
  puts "Make sure to create configuration files:"
  puts "  1. #{shared_path}/config/config.yml"
  puts "  2. #{shared_path}/config/database.yml"
  puts "  3. #{shared_path}/config/initializers/secret_token.rb"
end
after "deploy:setup", "setup_shared_dirs"

task :create_symlinks_to_shared_dirs, :roles => :app do
  run "#{try_sudo} ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
  run "#{try_sudo} ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  run "#{try_sudo} ln -nfs #{shared_path}/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
end
after "deploy:assets:symlink", "create_symlinks_to_shared_dirs"
