require 'httparty'
require 'json'

class Kele

  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    @email = email
    @password = password
    kele_client = self.class.post(
      '/sessions', {
      query: { email: email, password: password }
    })

     @authentication_token = kele_client['auth_token']
  end


  def get_me

    response = self.class.get(
      '/users/me', {
      headers: { "authorization" => @authentication_token }
    })
    JSON.parse(response.body)
  end

end
