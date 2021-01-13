defmodule NflRushing.Statistics.FootballPlayer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "football_players" do
    field :att, :float
    field :att_g, :float
    field :avg, :float
    field :first_down, :float
    field :first_down_porcent, :float
    field :forty_plus, :float
    field :fum, :float
    field :lng, :string
    field :player, :string
    field :pos, :string
    field :td, :float
    field :team, :string
    field :twenty_plus, :float
    field :yds, :float
    field :yds_g, :float

    timestamps()
  end

  @doc false
  def changeset(football_player, attrs) do
    football_player
    |> cast(attrs, [:player, :team, :pos, :att, :att_g, :yds, :avg, :yds_g, :td, :lng, :first_down, :first_down_porcent, :twenty_plus, :forty_plus, :fum])
    |> validate_required([:player, :team, :pos, :att, :att_g, :yds, :avg, :yds_g, :td, :lng, :first_down, :first_down_porcent, :twenty_plus, :forty_plus, :fum])
  end
end
