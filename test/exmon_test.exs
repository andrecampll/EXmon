defmodule ExmonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias Exmon.Player

  describe "create_player/4" do
    test "Returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{
          move_avg: :chute,
          move_heal: :cura,
          move_rnd: :soco
        },
        name: "John Doe"
      }

      assert Exmon.create_player("John Doe", :soco, :chute, :cura) == expected_response
    end
  end

  describe "start_game/1" do
    test "Returns start game message" do
      player = Player.build("John Doe", :soco, :chute, :cura)

      messages = capture_io(fn ->
        assert Exmon.start_game(player) == :ok
      end)


      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("John Doe", :soco, :chute, :cura)

      capture_io(fn ->
        Exmon.start_game(player)
      end)

      {:ok, player: player}
    end

    test "When the move is valid, do the move and the computer makes a move" do
      messages = capture_io(fn ->
        Exmon.make_move(:chute)
      end)

      assert messages =~ "The player attacked the computer"
      assert messages =~ "It's computer's turn"
      assert messages =~ "It's player's turn"
      assert messages =~ "status: :continue"
    end

    test "When the move is invalid, returns an error message" do
      messages = capture_io(fn ->
        Exmon.make_move(:invalid)
      end)

      assert messages =~ "Invalid move: invalid"
    end
  end
end
