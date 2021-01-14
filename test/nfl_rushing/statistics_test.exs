defmodule NflRushing.StatisticsTest do
  use NflRushing.DataCase

  alias NflRushing.Statistics

  describe "football_players" do
    alias NflRushing.Statistics.FootballPlayer

    @valid_attrs %{
      att: 120.5,
      att_g: 120.5,
      avg: 120.5,
      first_down: 120.5,
      first_down_porcent: 120.5,
      forty_plus: 120.5,
      fum: 120.5,
      lng: "some lng",
      player: "some player",
      pos: "some pos",
      td: 120.5,
      team: "some team",
      twenty_plus: 120.5,
      yds: 120.5,
      yds_g: 120.5
    }
    @update_attrs %{
      att: 456.7,
      att_g: 456.7,
      avg: 456.7,
      first_down: 456.7,
      first_down_porcent: 456.7,
      forty_plus: 456.7,
      fum: 456.7,
      lng: "some updated lng",
      player: "some updated player",
      pos: "some updated pos",
      td: 456.7,
      team: "some updated team",
      twenty_plus: 456.7,
      yds: 456.7,
      yds_g: 456.7
    }
    @invalid_attrs %{
      att: nil,
      att_g: nil,
      avg: nil,
      first_down: nil,
      first_down_porcent: nil,
      forty_plus: nil,
      fum: nil,
      lng: nil,
      player: nil,
      pos: nil,
      td: nil,
      team: nil,
      twenty_plus: nil,
      yds: nil,
      yds_g: nil
    }

    def football_player_fixture(attrs \\ %{}) do
      {:ok, football_player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Statistics.create_football_player()

      football_player
    end

    test "list_football_players/0 returns all football_players" do
      football_player = football_player_fixture()
      assert Statistics.list_football_players() == [football_player]
    end

    test "list_football_players/1 returns 2 football_players in first page" do
      criteria = [
        paginate: %{page: 1, per_page: 2}
      ]

      football_player_fixture()
      football_player_fixture()

      assert length(Statistics.list_football_players(criteria)) == 2
    end

    test "get_football_player!/1 returns the football_player with given id" do
      football_player = football_player_fixture()
      assert Statistics.get_football_player!(football_player.id) == football_player
    end

    test "create_football_player/1 with valid data creates a football_player" do
      assert {:ok, %FootballPlayer{} = football_player} =
               Statistics.create_football_player(@valid_attrs)

      assert football_player.att == 120.5
      assert football_player.att_g == 120.5
      assert football_player.avg == 120.5
      assert football_player.first_down == 120.5
      assert football_player.first_down_porcent == 120.5
      assert football_player.forty_plus == 120.5
      assert football_player.fum == 120.5
      assert football_player.lng == "some lng"
      assert football_player.player == "some player"
      assert football_player.pos == "some pos"
      assert football_player.td == 120.5
      assert football_player.team == "some team"
      assert football_player.twenty_plus == 120.5
      assert football_player.yds == 120.5
      assert football_player.yds_g == 120.5
    end

    test "create_football_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Statistics.create_football_player(@invalid_attrs)
    end

    test "update_football_player/2 with valid data updates the football_player" do
      football_player = football_player_fixture()

      assert {:ok, %FootballPlayer{} = football_player} =
               Statistics.update_football_player(football_player, @update_attrs)

      assert football_player.att == 456.7
      assert football_player.att_g == 456.7
      assert football_player.avg == 456.7
      assert football_player.first_down == 456.7
      assert football_player.first_down_porcent == 456.7
      assert football_player.forty_plus == 456.7
      assert football_player.fum == 456.7
      assert football_player.lng == "some updated lng"
      assert football_player.player == "some updated player"
      assert football_player.pos == "some updated pos"
      assert football_player.td == 456.7
      assert football_player.team == "some updated team"
      assert football_player.twenty_plus == 456.7
      assert football_player.yds == 456.7
      assert football_player.yds_g == 456.7
    end

    test "update_football_player/2 with invalid data returns error changeset" do
      football_player = football_player_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Statistics.update_football_player(football_player, @invalid_attrs)

      assert football_player == Statistics.get_football_player!(football_player.id)
    end

    test "delete_football_player/1 deletes the football_player" do
      football_player = football_player_fixture()
      assert {:ok, %FootballPlayer{}} = Statistics.delete_football_player(football_player)

      assert_raise Ecto.NoResultsError, fn ->
        Statistics.get_football_player!(football_player.id)
      end
    end

    test "change_football_player/1 returns a football_player changeset" do
      football_player = football_player_fixture()
      assert %Ecto.Changeset{} = Statistics.change_football_player(football_player)
    end
  end
end
