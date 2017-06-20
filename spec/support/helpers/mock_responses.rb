module MockResponses
  def twenty_valid_asteroids
    path = %w[spec support helpers api_responses neo twenty_valid.txt]
    File.open(Rails.root.join(*path), 'rb', &:read)
  end

  def nineteen_valid_of_twenty_asteroids
    path = %w[spec support helpers api_responses neo nineteen_valid_of_twenty.txt]
    File.open(Rails.root.join(*path), 'rb', &:read)
  end
end
