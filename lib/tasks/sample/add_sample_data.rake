namespace :sample do
  desc 'Add sample data to the database'
  task add: :environment do
    return if ENV['NO_SAMPLE_DATA']
    puts 'Adding users'
    User.destroy_all
    User.create email: 'scheduler@astronomania.co',
                password: 'password',
                password_confirmation: 'password'
    puts 'Done adding users'
  end
end
