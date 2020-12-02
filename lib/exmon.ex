defmodule Exmon do
  alias Exmon.Player

  def create_player(move_rnd, move_avg, move_heal, name ) do
    Player.build(move_rnd, move_avg, move_heal, name)
  end
end
