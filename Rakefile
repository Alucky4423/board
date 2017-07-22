
desc "Install dependenies"
task :dependence do
  sh "bundle install --path vendor/bundle --without=production"
end

desc "db task"
namespace :db do

  desc "migrations"
  task :migration do
    sh "bundle exec sequel -m db/migrations sqlite://db/database.db -l sequel.log"
  end

  desc "database reset"
  task "reset" do
    sh "bundle exec sequel -m db/migrations sqlite://db/database.db -M 0"
  end
end

