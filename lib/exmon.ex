defmodule Exmon do
  alias Exmon.{Game,Player}
  alias Exmon.Game.Status

  @computer_name "Robot"

  def create_player(move_rnd, move_avg, move_heal, name ) do
    Player.build(move_rnd, move_avg, move_heal, name)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :real)
    |> Game.start(player)

    Status.print_round_message()
  end
end
