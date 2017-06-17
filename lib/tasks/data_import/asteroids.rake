namespace :data_import do
  desc 'Insert and update asteroid data from NASA'
  task asteroids: :environment do
    puts 'Importing asteroid data'
    DataImport::Asteroids.call
  end
end
