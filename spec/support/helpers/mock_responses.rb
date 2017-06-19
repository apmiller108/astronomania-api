module MockResponses
  def neo_list
    recorded_response_body = Rails.root.join('spec',
                                             'support',
                                             'helpers',
                                             'api_responses',
                                             'neo_list.txt')
    File.open(recorded_response_body, 'rb', &:read)
  end
end
