module LostShip
  module Views
    # @example
    #           10        20        30        40        50        60        70        80
    #   ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
    #   __Pilots__ (10 char)                   __Scout Ships__ (10 char)
    #   1) Athena: 2 kills                     a) Red One: 100%
    #   2) Freya: 18 kills, injured 2 leaps    b) Red Two: 50%
    #   3) Artemis: 0 kills                    c) Red Three: inop
    #   4) Hera: 4 kills                       d) Red Four: 100%
    #   5) Xena: 1 kills, injured 1 leap       e) Red Five: inop
    #                                          f) Red Five: 100%
    #
    #   ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
    #           10        20        30        40        50        60        70        80
    class ScoutsAndPilotsView
      def self.render(**kwargs)
        new(**kwargs).render
      end

      def initialize(game:, output_buffer: $stdout, with_ruler: false)
        @game = game
        @output_buffer = output_buffer
        @with_ruler = with_ruler
      end
      attr_reader :output_buffer, :with_ruler, :game

      def colony_ship
        game.fleet.ship
      end
      private :colony_ship

      TWO_COLUMN_SPRINTF = "%-39s %-40s"
      THREE_COLUMN_SPRINTF = "%-26s %-26s %-26s"
      TWO_COLUMN_FIRST_WIDE_SPRINTF = "%-53s %-26s"
      def render
        if with_ruler
          output_buffer.puts %(        10        20        30        40        50        60        70        80)
          output_buffer.puts %(----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+)
        end
        output_buffer.puts sprintf(
          TWO_COLUMN_SPRINTF,
          "__Pilots__",
          "__Scout Ships__"
        )
        (0..5).each do |i|
          output_buffer.puts sprintf(
            TWO_COLUMN_SPRINTF,
            game.fleet.pilots[i].to_s,
            game.fleet.scouts[i],
          )
        end
        if with_ruler
          output_buffer.puts %(----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+)
          output_buffer.puts %(        10        20        30        40        50        60        70        80)
        end
      end
    end
  end
end
