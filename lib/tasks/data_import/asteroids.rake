namespace :import do
  desc 'Insert and update asteroid data from NASA'
  task asteroids: :environment do
    puts 'Importing asteroid data'
    Importer::Asteroids::Import.call
  end
end
