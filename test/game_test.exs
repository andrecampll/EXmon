defmodule Exmon.GameTest do
  use ExUnit.Case

  alias Exmon.{Player, Game}

  describe "start/2" do
    test "Starts the game state" do
      player = Player.build("John Doe", :soco, :chute, :cura)
      computer = Player.build("computer", :soco, :chute, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "Returns the current game state" do
      player = Player.build("John Doe", :soco, :chute, :cura)
      computer = Player.build("computer", :soco, :chute, :cura)

      Game.start(computer, player)

      expected_response =  %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute,
          move_heal: :cura,
          move_rnd: :soco},
          name: "computer"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute,
          move_heal: :cura,
          move_rnd: :soco},
          name: "John Doe"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "Returns the game state updated" do
      player = Player.build("John Doe", :soco, :chute, :cura)
      computer = Player.build("computer", :soco, :chute, :cura)

      Game.start(computer, player)

      expected_response =  %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute,
          move_heal: :cura,
          move_rnd: :soco},
          name: "computer"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute,
          move_heal: :cura,
          move_rnd: :soco},
          name: "John Doe"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_response

      new_state =  %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :chute,
          move_heal: :cura,
          move_rnd: :soco},
          name: "computer"
        },
        player: %Player{
          life: 45,
          moves: %{move_avg: :chute,
          move_heal: :cura,
          move_rnd: :soco},
          name: "John Doe"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert Game.info() == expected_response
    end
  end
end
