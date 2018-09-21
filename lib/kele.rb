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

  def get_mentor_availability(mentor_id)
    mentor_response = self.class.get(
      "/mentors/#{mentor_id}/student_availability",
        headers: { "authorization" => @authentication_token }
      )

    # available = JSON.parse(mentor_response.body) #(1.whole list)

    # (2.available list using .each do)

    # available = []
    #   JSON.parse(mentor_response.body)["slots"].each do |availability|
    #     if availability["booked"] == nil
    #       available << availability
    #     end
    #   end
    #   available

    #(3. available list using select)
    
      JSON.parse(mentor_response.body)["slots"].select{ |availability| availability["booked"] == nil}

  end

end
