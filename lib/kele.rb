require 'httparty'

class Kele

  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    @email = email
    @password = password
    @authentication_token = self.class.post(
      '/sessions',
      { query: { email: @email, password: @password } } 
    )
  end

end
