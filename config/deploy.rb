set :application, 'fels'

# Define where can Capistrano access the source repository

# set :repo_url, 'https://github.com/[user name]/[application name].git'

set :repo_url, 'https://github.com/hoangtronghieu1812/FELS_20190104.git'

# Define where to put your application code

set :deploy_to, "/var/www/fels/"
set :migration_role, :app

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
set :rbenv_ruby, '2.6.0'

# Set the post-deployment instructions here

# Once the deployment is complete, Capistrano

# will begin performing them as described

# To learn more about creating tasks

# check out

# http://capistranorb.com/

# namespace: deploy do

# desc 'Restart application'

# task :restart do

# on roles(:app), in: :sequence, wait: 5 do

# # Your restart mechanism here, for example

# execute :touch, release_path.join('tmp/restart.txt')

# end

# end

# after :publishing, :restart

# after :restart, :clear_cache do

# on roles(:web), in: :groups, limit: 3, wait: 10 do

# # Here we can do anything such as

# # within release_path do

# #   execute :rake, 'cache:clear'

# # end

# end

# end

# end
namespace :deploy do
  desc "reload the database with seed data"
  after :restart, :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end
end
