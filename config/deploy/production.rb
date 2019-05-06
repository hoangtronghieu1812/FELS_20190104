# Define roles, user and IP address of deployment server

# role :name, %{[user]@[IP adde.]}

role :app, %w{troublehfrom18@10.0.37.78}
role :web, %w{troublehfrom18@10.0.37.78}
role :db,  %w{troublehfrom18@10.0.37.78}
set :rails_env, :production
set :branch, "master"

# Define server(s)

server '10.0.37.78', user: 'troublehfrom18', roles: %w{app db web}

# SSH Options

# See the example commented out section in the file

# for more options

# set :ssh_options, {
#     forward_agent: false,
#     auth_methods: %w(password),
#     password: ENV["deploy_password"],
#     user: 'troublehfrom18',
# }
