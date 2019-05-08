# Define roles, user and IP address of deployment server

# role :name, %{[user]@[IP adde.]}

role :app, %w{hieubth@10.0.33.25}
role :web, %w{hieubth@10.0.33.25}
role :db,  %w{hieubth@10.0.33.25}
# Define server(s)

# SSH Options

# See the example commented out section in the file

# for more options

# set :ssh_options, {
#     forward_agent: false,
#     auth_methods: %w(password),
#     password: ENV["deploy_password"],
#     user: 'troublehfrom18',
# }
