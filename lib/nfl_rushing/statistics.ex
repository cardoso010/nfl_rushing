defmodule NflRushing.Statistics do
  @moduledoc """
  The Statistics context.
  """

  import Ecto.Query, warn: false
  alias NflRushing.Repo

  alias NflRushing.Statistics.FootballPlayer

  @doc """
  Returns a list of football_players matching the given `criteria`.

  Example Criteria:

  [
   paginate: %{page: 2, per_page: 5},
   sort: %{sort_by: :item, sort_order: :asc},
   filter: %{player: ""}
  ]
  """

  def list_football_players(criteria) when is_list(criteria) do
    query = from(d in FootballPlayer)

    Enum.reduce(criteria, query, fn
      {:paginate, %{page: page, per_page: per_page}}, query ->
        from q in query,
          offset: ^((page - 1) * per_page),
          limit: ^per_page

      {:sort, %{sort_by: sort_by, sort_order: sort_order}}, query ->
        from q in query, order_by: [{^sort_order, ^sort_by}]

      {:filter, %{player: player}}, query ->
        from q in query, where: like(q.player, ^"%#{player}%")
    end)
    |> Repo.all()
  end

  @doc """
  Returns the list of football_players.

  ## Examples

      iex> list_football_players()
      [%FootballPlayer{}, ...]

  """
  def list_football_players do
    Repo.all(FootballPlayer)
  end

  @doc """
  Gets a single football_player.

  Raises `Ecto.NoResultsError` if the Football player does not exist.

  ## Examples

      iex> get_football_player!(123)
      %FootballPlayer{}

      iex> get_football_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_football_player!(id), do: Repo.get!(FootballPlayer, id)

  @doc """
  Creates a football_player.

  ## Examples

      iex> create_football_player(%{field: value})
      {:ok, %FootballPlayer{}}

      iex> create_football_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_football_player(attrs \\ %{}) do
    %FootballPlayer{}
    |> FootballPlayer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a football_player.

  ## Examples

      iex> update_football_player(football_player, %{field: new_value})
      {:ok, %FootballPlayer{}}

      iex> update_football_player(football_player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_football_player(%FootballPlayer{} = football_player, attrs) do
    football_player
    |> FootballPlayer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a football_player.

  ## Examples

      iex> delete_football_player(football_player)
      {:ok, %FootballPlayer{}}

      iex> delete_football_player(football_player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_football_player(%FootballPlayer{} = football_player) do
    Repo.delete(football_player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking football_player changes.

  ## Examples

      iex> change_football_player(football_player)
      %Ecto.Changeset{data: %FootballPlayer{}}

  """
  def change_football_player(%FootballPlayer{} = football_player, attrs \\ %{}) do
    FootballPlayer.changeset(football_player, attrs)
  end
end
