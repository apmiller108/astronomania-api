namespace :import do
  desc 'Insert and update asteroid(neo) data from NASA'
  task asteroids: :environment do
    puts 'Importing asteroids from NASA NeoWs'
    Importer::Asteroids::Import.call
  end
end
