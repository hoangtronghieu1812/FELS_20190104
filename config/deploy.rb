set :application, 'fels_20190104'

# Define where can Capistrano access the source repository

# set :repo_url, 'https://github.com/[user name]/[application name].git'

set :git, :scm
set :repo_url, 'https://github.com/hoangtronghieu1812/FELS_20190104'

# Define where to put your application code

set :deploy_to, "/home/troublehfrom18/environment/deploy/FELS_20190104"

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
set :rbenv_ruby, '2.6.0'

set :pty, true

set :format, :pretty

set :passenger_restart_with_touch, true


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
