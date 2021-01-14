defmodule NflRushingWeb.PageLiveTest do
  use NflRushingWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Football Players statistics"
    assert render(page_live) =~ "Football Players statistics"
  end
end
