class Recipe
  include HTTParty
  key_value = ENV['FOOD2FORK_KEY'] || '2d2566580c0b6f094d1ea4012eacf794'
  hostport = ENV['FOOD2FORK_SERVER_AND_PORT'] || 'www.food2fork.com'

  default_options.update(verify: false) # Turn off SSL verification
  base_uri "http://#{hostport}/api"
  default_params key: key_value
  format :json

  def self.for term
    get("/search", query: { q: term})["recipes"]
  end

end