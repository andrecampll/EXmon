defmodule Exmon.Game.Status do
  alias Exmon.Game
  def print_round_message do
    IO.puts("\n=====The game is started!=====\n")
    IO.inspect(Game.info())
    IO.puts("--------------------")
  end
end
