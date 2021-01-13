defmodule NflRushingWeb.FootballPlayerLive.FormComponent do
  use NflRushingWeb, :live_component

  alias NflRushing.Statistics

  @impl true
  def update(%{football_player: football_player} = assigns, socket) do
    changeset = Statistics.change_football_player(football_player)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"football_player" => football_player_params}, socket) do
    changeset =
      socket.assigns.football_player
      |> Statistics.change_football_player(football_player_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"football_player" => football_player_params}, socket) do
    save_football_player(socket, socket.assigns.action, football_player_params)
  end

  defp save_football_player(socket, :edit, football_player_params) do
    case Statistics.update_football_player(socket.assigns.football_player, football_player_params) do
      {:ok, _football_player} ->
        {:noreply,
         socket
         |> put_flash(:info, "Football player updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_football_player(socket, :new, football_player_params) do
    case Statistics.create_football_player(football_player_params) do
      {:ok, _football_player} ->
        {:noreply,
         socket
         |> put_flash(:info, "Football player created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
