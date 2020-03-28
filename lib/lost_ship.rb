require "lost_ship/version"
require "lost_ship/schema"
require "json"

module LostShip
  class Error < StandardError; end
  class InvalidGameStateError < Error; end

  # @param path [String] the path to the JSON state of a game
  #
  # @return LostShip::Game set to the given state
  def self.load_from(path:)
    document = File.read(path)
    json = JSON.parse(document)
    schema_result = Schema.call(json)
    if schema_result.success?
      # TODO
    else
      raise InvalidGameStateError, schema_result.errors.to_h.inspect
    end
  end
end
