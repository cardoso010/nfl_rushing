defmodule NflRushingWeb.FootballPlayerLive.Show do
  use NflRushingWeb, :live_view

  alias NflRushing.Statistics

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:football_player, Statistics.get_football_player!(id))}
  end

  defp page_title(:show), do: "Show Football player"
  defp page_title(:edit), do: "Edit Football player"
end
