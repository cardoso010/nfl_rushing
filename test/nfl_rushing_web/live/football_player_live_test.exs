defmodule NflRushingWeb.FootballPlayerLiveTest do
  use NflRushingWeb.ConnCase

  import Phoenix.LiveViewTest

  alias NflRushing.Statistics

  @create_attrs %{att: 120.5, att_g: 120.5, avg: 120.5, first_down: 120.5, first_down_porcent: 120.5, forty_plus: 120.5, fum: 120.5, lng: "some lng", player: "some player", pos: "some pos", td: 120.5, team: "some team", twenty_plus: 120.5, yds: 120.5, yds_g: 120.5}
  @update_attrs %{att: 456.7, att_g: 456.7, avg: 456.7, first_down: 456.7, first_down_porcent: 456.7, forty_plus: 456.7, fum: 456.7, lng: "some updated lng", player: "some updated player", pos: "some updated pos", td: 456.7, team: "some updated team", twenty_plus: 456.7, yds: 456.7, yds_g: 456.7}
  @invalid_attrs %{att: nil, att_g: nil, avg: nil, first_down: nil, first_down_porcent: nil, forty_plus: nil, fum: nil, lng: nil, player: nil, pos: nil, td: nil, team: nil, twenty_plus: nil, yds: nil, yds_g: nil}

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

    test "saves new football_player", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.football_player_index_path(conn, :index))

      assert index_live |> element("a", "New Football player") |> render_click() =~
               "New Football player"

      assert_patch(index_live, Routes.football_player_index_path(conn, :new))

      assert index_live
             |> form("#football_player-form", football_player: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#football_player-form", football_player: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.football_player_index_path(conn, :index))

      assert html =~ "Football player created successfully"
      assert html =~ "some lng"
    end

    test "updates football_player in listing", %{conn: conn, football_player: football_player} do
      {:ok, index_live, _html} = live(conn, Routes.football_player_index_path(conn, :index))

      assert index_live |> element("#football_player-#{football_player.id} a", "Edit") |> render_click() =~
               "Edit Football player"

      assert_patch(index_live, Routes.football_player_index_path(conn, :edit, football_player))

      assert index_live
             |> form("#football_player-form", football_player: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#football_player-form", football_player: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.football_player_index_path(conn, :index))

      assert html =~ "Football player updated successfully"
      assert html =~ "some updated lng"
    end

    test "deletes football_player in listing", %{conn: conn, football_player: football_player} do
      {:ok, index_live, _html} = live(conn, Routes.football_player_index_path(conn, :index))

      assert index_live |> element("#football_player-#{football_player.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#football_player-#{football_player.id}")
    end
  end

  describe "Show" do
    setup [:create_football_player]

    test "displays football_player", %{conn: conn, football_player: football_player} do
      {:ok, _show_live, html} = live(conn, Routes.football_player_show_path(conn, :show, football_player))

      assert html =~ "Show Football player"
      assert html =~ football_player.lng
    end

    test "updates football_player within modal", %{conn: conn, football_player: football_player} do
      {:ok, show_live, _html} = live(conn, Routes.football_player_show_path(conn, :show, football_player))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Football player"

      assert_patch(show_live, Routes.football_player_show_path(conn, :edit, football_player))

      assert show_live
             |> form("#football_player-form", football_player: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#football_player-form", football_player: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.football_player_show_path(conn, :show, football_player))

      assert html =~ "Football player updated successfully"
      assert html =~ "some updated lng"
    end
  end
end
