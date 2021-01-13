defmodule NflRushing.Repo.Migrations.CreateFootballPlayers do
  use Ecto.Migration

  def change do
    create table(:football_players) do
      add :player, :string
      add :team, :string
      add :pos, :string
      add :att, :float
      add :att_g, :float
      add :yds, :float
      add :avg, :float
      add :yds_g, :float
      add :td, :float
      add :lng, :string
      add :first_down, :float
      add :first_down_porcent, :float
      add :twenty_plus, :float
      add :forty_plus, :float
      add :fum, :float

      timestamps()
    end

  end
end
