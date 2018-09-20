module Roadmap

  def get_roadmap(chain_id)
    #chain_id = 6584
    roadmap_response = self.class.get(
      "/roadmaps/#{chain_id}",
      headers: { "authorization" => @authentication_token }
    )
    JSON.parse(roadmap_response.body)
  end

  def get_checkpoint(checkpoint_id)
    #checkpoint_id = 2189/2947
    checkpoint_respond = self.class.get(
      "/checkpoints/#{checkpoint_id}",
      headers: { "authorization" => @authentication_token }
    )
    JSON.parse(checkpoint_respond.body)
  end

end
