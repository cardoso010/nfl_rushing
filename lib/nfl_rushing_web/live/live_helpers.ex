defmodule NflRushingWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `NflRushingWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, NflRushingWeb.FootballPlayerLive.FormComponent,
        id: @football_player.id || :new,
        action: @live_action,
        football_player: @football_player,
        return_to: Routes.football_player_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, NflRushingWeb.ModalComponent, modal_opts)
  end
end
