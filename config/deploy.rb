# config/deploy.rb

lock "~> 3.18.1"

set :application, "inferifi_attendance"
set :deploy_user, "alche"
set :assets_roles, []
set :repo_url, "git@github.com:faisalhrms/inferifi_attendance.git"

set :pty, true
set :ssh_options, { forward_agent: true, user: fetch(:deploy_user).to_sym }
set :use_sudo, false
set :deploy_port, 82

# rbenv
set :rbenv_path, "/home/#{fetch(:deploy_user)}/.rbenv"
set :rbenv_type, :user
set :rbenv_ruby, "3.0.0"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]

# whenever
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

# bundler (IMPORTANT: do not link vendor/bundle)
set :bundle_without, %w[development test].join(" ")
set :bundle_path, -> { shared_path.join("bundle") }
set :bundle_flags, "--deployment"
set :bundle_binstubs, nil

set :keep_releases, 5

set :linked_files, %w[config/database.yml config/local_env.yml]
set :linked_dirs, %w[
  log
  tmp/pids
  tmp/cache
  tmp/sockets
  public/system
  public/pdf
  public/excel
  public/img
]

set :tests, []

set(:config_files, %w[
  nginx.conf
  database.example.yml
  local_env.example.yml
  log_rotation
  unicorn.rb
  unicorn_init.sh
])

set(:executable_config_files, %w[
  unicorn_init.sh
])

set(:symlinks, [
  { source: "nginx.conf",       link: "/etc/nginx/sites-enabled/{{full_app_name}}" },
  { source: "unicorn_init.sh",  link: "/etc/init.d/unicorn_{{full_app_name}}" },
  { source: "log_rotation",     link: "/etc/logrotate.d/{{full_app_name}}" }
])

namespace :deploy do
  namespace :assets do
    task :precompile do
      info "Skipping assets precompilation because this is an API-only app."
    end
  end
end

namespace :deploy do
  before :deploy, "deploy:check_revision"
  before :deploy, "deploy:run_tests"

  after :finishing, "deploy:cleanup"

  before "deploy:setup_config", "nginx:remove_default_vhost"
  after  "deploy:setup_config", "nginx:restart"

  after "deploy:publishing", "deploy:restart"
  after "deploy:publishing", "delayed_job:restart"
end
