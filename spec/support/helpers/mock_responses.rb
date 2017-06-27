module MockResponses
  BASE_PATH = %w[spec support helpers api_responses].freeze
  def twenty_valid_asteroids
    path = BASE_PATH + %w[neo twenty_valid.txt]
    File.open(Rails.root.join(*path), 'rb', &:read)
  end

  def nineteen_valid_of_twenty_asteroids
    path = BASE_PATH + %w[neo nineteen_valid_of_twenty.txt]
    File.open(Rails.root.join(*path), 'rb', &:read)
  end

  def valid_asteroid
    path = BASE_PATH + %w[neo valid_asteroid.txt]
    File.open(Rails.root.join(*path), 'rb', &:read)
  end

  def invalid_asteroid
    path = BASE_PATH + %w[neo invalid_asteroid.txt]
    File.open(Rails.root.join(*path), 'rb', &:read)
  end

  def valid_apod
    path = BASE_PATH + %w[apods valid_apod.txt]
    File.open(Rails.root.join(*path), 'rb', &:read)
  end

  def invalid_apod
    path = BASE_PATH + %w[apods invalid_apod.txt]
    File.open(Rails.root.join(*path), 'rb', &:read)
  end

  def bad_request
    path = BASE_PATH + %w[nasa_bad_request.txt]
    File.open(Rails.root.join(*path), 'rb', &:read)
  end
end
