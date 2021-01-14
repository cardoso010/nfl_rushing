defmodule NflRushingWeb.FootballPlayerLive.Index do
  use NflRushingWeb, :live_view

  alias NflRushing.Statistics
  alias NflRushing.Statistics.FootballPlayer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [football_players: []]}
  end

  @impl true
  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "5")

    paginate_options = %{page: page, per_page: per_page}
    football_players = Statistics.list_football_players(paginate: paginate_options)

    socket =
      assign(socket,
        options: paginate_options,
        football_players: football_players
      )

    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("select-per-page", %{"per-page" => per_page}, socket) do
    per_page = String.to_integer(per_page)

    socket =
      push_patch(socket,
        to:
          Routes.football_player_index_path(
            socket,
            :index,
            page: socket.assigns.options.page,
            per_page: per_page
          )
      )

    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    football_player = Statistics.get_football_player!(id)
    {:ok, _} = Statistics.delete_football_player(football_player)

    {:noreply, assign(socket, :football_players, list_football_players())}
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

  defp pagination_link(socket, text, page, per_page, class) do
    live_patch(text,
      to:
        Routes.football_player_index_path(
          socket,
          :index,
          page: page,
          per_page: per_page
        ),
      class: class
    )
  end

  defp list_football_players do
    Statistics.list_football_players()
  end
end
