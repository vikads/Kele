require 'httparty'
require 'json'
require './lib/roadmap'

class Kele

  include HTTParty
  include Roadmap
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    @email = email
    @password = password
    kele_client = self.class.post(
      '/sessions', {
      query: { email: email, password: password }
    })

     @authentication_token = kele_client['auth_token']

     raise "Ups. Check your email and password. Try again" if @authentication_token.nil?

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

      JSON.parse(mentor_response.body)["slots"].select{ |availability| availability["booked"] == nil}

  end

  def get_messages(page=1)

      messages_response = self.class.get(
        "/message_threads",
        headers: { "authorization" => @authentication_token },
        query: { "page" => page }
      )

    JSON.parse(messages_response.body)
  end

  def create_message(sender, recipient_id, stripped_text, token: nil, subject: nil)

    query = {}
    query["token"] = token unless token.nil?
    query["subject"] = subject unless subject.nil?
    query["sender"] = sender
    query["recipient_id"] = recipient_id
    query["stripped-text"] = stripped_text

    puts "Sending query: #{query}"
    puts query

    new_message_response = self.class.post(
      "/messages",
      headers: {
        "authorization" => @authentication_token,
      },
      query: query
    )

    puts "The message was sent" if new_message_response.success?
    
  end
end
