require 'csv'

namespace :sample_data do
  desc 'Add sample data to the database'
  task add: :environment do
    return if ENV['NO_SAMPLE_DATA']
    Rake::Task['sample_data:add_users'].execute
    Rake::Task['sample_data:add_neos'].execute
  end

  desc 'Add sample user data to the database'
  task add_users: :environment do
    return if ENV['NO_SAMPLE_DATA']

    puts 'Adding users'
    User.destroy_all
    User.create! email: 'scheduler@astronomania.co',
                 password: 'password',
                 password_confirmation: 'password',
                 admin: true
    puts 'Done adding users'
  end
end
