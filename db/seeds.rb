seed_file = Rails.root.join("db/seeds/#{Rails.env}.rb")
require seed_file if seed_file.exist? && !ENV['NO_SEED_DATA']
