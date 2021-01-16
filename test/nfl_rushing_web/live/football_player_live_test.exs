defmodule NflRushingWeb.FootballPlayerLiveTest do
  use NflRushingWeb.ConnCase

  import Phoenix.LiveViewTest

  alias NflRushing.Statistics

  @create_attrs %{
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

  defp fixture(:football_player) do
    {:ok, football_player} = Statistics.create_football_player(@create_attrs)
    football_player
  end

  defp create_football_player(_) do
    football_player = fixture(:football_player)
    %{football_player: football_player}
  end

  describe "Index" do
    setup [:create_football_player]

    test "lists all football_players", %{conn: conn, football_player: football_player} do
      {:ok, _index_live, html} = live(conn, Routes.football_player_index_path(conn, :index))

      assert html =~ "Listing Football players"
      assert html =~ football_player.lng
    end
  end
end
