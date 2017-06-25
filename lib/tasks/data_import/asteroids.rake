namespace :import do
  desc 'Insert and update asteroid(neo) data from NASA'
  task asteroids: :environment do
    puts 'Importing asteroids from NASA NeoWs'
    Importer::Asteroids::Import.call
  end

  desc 'Insert and update Astronomy Picture of the Day from NASA'
  task apod: :environment do
    puts 'Importing the Astronomy Picture of the Day from NASA'
    Importer::Apod::Import.call
  end
end
