# default_environment['PATH'] = "/opt/ruby/bin:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin"

# set :user, ENV['CAPUSER']
# set :runner, "the2ofus"
# set :application, "the2ofus"
# set :rails_env, "production"
# set :deploy_to, "/apps/#{runner}/#{application}-git"
# set :use_sudo, true

# ssh_options[:paranoid] = false

# role :rails, '144.76.29.26:58022', '144.76.29.25:58022', :primary => true
# role :db, '144.76.29.26:58022'

# alias :old_run :run
# def run(command)
#   old_run "#{sudo :as => runner} -i sh -c '#{command}'"
# end

# namespace :deploy do
#   task :default do
#     update
#     migrate
#     precompile_assets
#     restart
#   end

#   task :setup do
#     run "cd #{deploy_to}; mkdir -p log tmp; cp config/database.yml.production config/database.yml; cp config/lam_auth.yml.production config/lam_auth.yml; cp config/apps.yml.production config/apps.yml"
#   end

#   task :update do
#     run "cd #{deploy_to}; git checkout db/schema.rb; git pull; bundle install --deployment --without development test"
#   end

#   task :migrate, :roles => :db do
#     run "cd #{deploy_to} && RAILS_ENV=#{rails_env} bundle exec rake db:migrate"
#   end

#   task :precompile_assets do
#     run "cd #{deploy_to}; RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
#   end

#   task :restart do
#     run "cd #{deploy_to}; touch tmp/restart.txt;"
#   end
# end
