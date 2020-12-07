defmodule Exmon do
  alias Exmon.{Game,Player}
  alias Exmon.Game.{Status, Actions}

  @computer_name "Robot"
  @moves [:move_avg, :move_rnd, :move_heal]

  def create_player(move_rnd, move_avg, move_heal, name ) do
    Player.build(move_rnd, move_avg, move_heal, name)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Status.print_round_message(Game.info())
  end

  def make_move(move) do
    move
    |> Actions.fetch_move()
    |> do_move()

    computer_move(Game.info())
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)
  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@moves)}

    do_move(move)
  end

  defp computer_move(_), do: :ok
end
