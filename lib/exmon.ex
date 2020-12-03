defmodule Exmon do
  alias Exmon.{Game,Player}
  alias Exmon.Game.{Status, Actions}

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

  def make_move(move) do
    move
    |> Actions.fetch_move()
    |> do_move()
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)
  defp do_move({:ok, move}) do
    case move do
      :move_heal -> "realiza cura"
      move -> Actions.attack(move)
    end
  end
end
