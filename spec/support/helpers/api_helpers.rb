module ApiHelpers
  def json
    JSON.parse response.body
  end

  def json_attrs
    json['data']['attributes']
  end

  def authenticated_headers(user)
    jwt = JsonWebToken.new(payload: { user_id: user.id })
    { 'Authorization': "Beaer #{jwt.auth_token}" }
  end
end
