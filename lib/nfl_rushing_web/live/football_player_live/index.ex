defmodule NflRushingWeb.FootballPlayerLive.Index do
  use NflRushingWeb, :live_view

  alias NflRushing.Statistics
  alias NflRushing.Statistics.FootballPlayer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :football_players, list_football_players())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Football player")
    |> assign(:football_player, Statistics.get_football_player!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Football player")
    |> assign(:football_player, %FootballPlayer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Football players")
    |> assign(:football_player, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    football_player = Statistics.get_football_player!(id)
    {:ok, _} = Statistics.delete_football_player(football_player)

    {:noreply, assign(socket, :football_players, list_football_players())}
  end

  defp list_football_players do
    Statistics.list_football_players()
  end
end
