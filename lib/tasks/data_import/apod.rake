namespace :import do
  desc 'Insert and update Astronomy Picture of the Day from NASA'
  task apod: :environment do
    puts 'Importing the Astronomy Picture of the Day from NASA'
    Importer::Apods::Import.call
  end
end
