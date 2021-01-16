defmodule NflRushingWeb.FootballPlayerLive.Index do
  use NflRushingWeb, :live_view

  alias NflRushing.Statistics
  alias NflRushing.Statistics.FootballPlayer
  alias NflRushing.Utils.CsvDownload
  alias NflRushing.Utils.Randomizer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [football_players: [], link_download: nil]}
  end

  @impl true
  def handle_params(params, _url, socket) do
    params_formated = get_params_formated(params)

    football_players =
      Statistics.list_football_players(
        paginate: params_formated.paginate_options,
        sort: params_formated.sort_options,
        filter: params_formated.filter
      )

    options =
      Map.merge(params_formated.paginate_options, params_formated.sort_options)
      |> Map.put(:player, params_formated.player)

    socket =
      assign(socket,
        options: options,
        football_players: football_players,
        link_download: params_formated.link_download
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
            per_page: per_page,
            sort_by: socket.assigns.options.sort_by,
            sort_order: socket.assigns.options.sort_order,
            player: socket.assigns.options.player
          )
      )

    {:noreply, socket}
  end

  def handle_event("filter", %{"player" => player}, socket) do
    params = get_params_from_socket(socket)

    filter = %{player: String.capitalize(player)}

    football_players =
      Statistics.list_football_players(
        paginate: params.paginate,
        sort: params.sort,
        filter: filter
      )

    options = Map.merge(params.paginate, params.sort) |> Map.put(:player, filter.player)

    socket =
      assign(
        socket,
        [options: options] ++
          [football_players: football_players, link_download: ""]
      )

    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    football_player = Statistics.get_football_player!(id)
    {:ok, _} = Statistics.delete_football_player(football_player)

    {:noreply, assign(socket, :football_players, Statistics.list_football_players())}
  end

  def handle_event("clear", _, socket) do
    socket =
      push_patch(socket,
        to:
          Routes.football_player_index_path(
            socket,
            :index,
            page: 1,
            per_page: 5,
            sort_by: :id,
            sort_order: :asc,
            player: "",
            link_download: ""
          )
      )

    {:noreply, socket}
  end

  def handle_event("prepare_file", _, socket) do
    filename = Randomizer.randomizer(12)
    params = get_params_from_socket(socket)

    CsvDownload.generate_csv(
      [sort: params.sort, filter: params.filter],
      filename
    )

    link_download = Routes.static_path(socket, "/downloads/#{filename}.csv")

    socket =
      assign(
        socket,
        :link_download,
        link_download
      )

    {:noreply, socket}
  end

  def handle_event("after_download", _, socket) do
    socket =
      assign(
        socket,
        :link_download,
        ""
      )

    {:noreply, socket}
  end

  defp get_params_from_socket(socket) do
    paginate = %{page: socket.assigns.options.page, per_page: socket.assigns.options.per_page}

    sort = %{
      sort_by: socket.assigns.options.sort_by,
      sort_order: socket.assigns.options.sort_order
    }

    filter = %{player: String.capitalize(socket.assigns.options.player)}

    %{paginate: paginate, sort: sort, filter: filter}
  end

  defp get_params_formated(params) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "5")

    sort_by = (params["sort_by"] || "id") |> String.to_atom()
    sort_order = (params["sort_order"] || "asc") |> String.to_atom()

    player = params["player"] || ""

    link_download = params["link_download"] || nil

    paginate_options = %{page: page, per_page: per_page}
    sort_options = %{sort_by: sort_by, sort_order: sort_order}

    filter = %{player: String.capitalize(player)}

    %{
      paginate_options: paginate_options,
      sort_options: sort_options,
      filter: filter,
      player: player,
      link_download: link_download
    }
  end

  defp pagination_link(socket, text, page, options) do
    live_patch(text,
      to:
        Routes.football_player_index_path(
          socket,
          :index,
          page: page,
          per_page: options.per_page,
          sort_by: options.sort_by,
          sort_order: options.sort_order,
          player: options.player
        )
    )
  end

  defp sort_link(socket, text, sort_by, options) do
    live_patch(text,
      to:
        Routes.football_player_index_path(
          socket,
          :index,
          sort_by: sort_by,
          sort_order: toggle_sort_order(options.sort_order),
          page: options.page,
          per_page: options.per_page,
          player: options.player
        )
    )
  end

  defp toggle_sort_order(:asc), do: :desc
  defp toggle_sort_order(:desc), do: :asc

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
end
