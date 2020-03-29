require "lost_ship/version"
require "lost_ship/models"
require "lost_ship/prompts"
require "lost_ship/views"
require "json"

module LostShip
  class Error < StandardError; end
  class InvalidGameStateError < Error; end

  # @param filename [String] the path to the JSON state of a game.
  #
  # @return LostShip::Models::Game set to the given state.
  # @raise LostShip::InvalidGameStateError when file at the given path
  #        is not a valid game state.
  #
  # @see LostShip::Models::Schema for valid schema structure.
  def self.load_from(filename:)
    document = File.read(filename)
    json = JSON.parse(document)
    schema_result = Models::Game::Schema.call(json)
    if schema_result.success?
      Models::Game.new(json)
    else
      raise InvalidGameStateError, schema_result.errors.to_h.inspect
    end
  end

  # @param filename [String] the path to the JSON state of a game.
  # @param game [LostShip::Models::Game]
  def self.write!(filename:, game:)
    content = JSON.dump(game.to_h)
    Dry::CLI::Utils::Files.write(filename, content)
  end

  def self.prompt(prompt_name, **kwargs)
    Prompts.run(prompt_name, **kwargs)
  end

  def self.render(view_name, filename:, **kwargs)
    game = load_from(filename: filename)
    Views.render(view_name, game: game, **kwargs)
  end

  # @param ship_name [String] the name of the colony ship
  # @param scout_names [Array<String>] the names of the scout ships
  # @param pilot_names [Array<String>] the names of the pilots
  # @param filename [nil, String] write the game to filename (if given)
  #
  # @see LostShip::Models::Game
  def self.start(ship_name:, scout_names:, pilot_names:, filename: nil)
    game = Models::Game.new(
      fleet: {
        ship: { name: ship_name },
        scouts: Array(scout_names).map { |name| { name: name } },
        pilots: Array(pilot_names).map { |name| { name: name } }
      }
    )
    write!(filename: filename, game: game) if filename
    game
  end
end
