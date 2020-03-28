require "lost_ship/version"
require "lost_ship/models"
require "json"

module LostShip
  class Error < StandardError; end
  class InvalidGameStateError < Error; end

  # @param path [String] the path to the JSON state of a game.
  #
  # @return LostShip::Models::Game set to the given state.
  # @raise LostShip::InvalidGameStateError when file at the given path
  #        is not a valid game state.
  #
  # @see LostShip::Models::Schema for valid schema structure.
  def self.load_from(path:)
    document = File.read(path)
    json = JSON.parse(document)
    schema_result = Models::Game::Schema.call(json)
    if schema_result.success?
      Models::Game.new(json)
    else
      raise InvalidGameStateError, schema_result.errors.to_h.inspect
    end
  end
end
