set :stage, :production
set :branch, 'main'
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :server_name, 'apps.syscon.cc:82'

server 'apps.syscon.cc',
       user: 'alche',
       roles: %w[app web db],
       primary: true,
       port: 2222

set :ssh_options, {
  user: 'alche',
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey),
  port: 2222
}

set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:full_app_name)}"
set :rails_env, :production
set :unicorn_worker_count, 16
set :enable_ssl, false
