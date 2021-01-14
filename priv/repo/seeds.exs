# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NflRushing.Repo.insert!(%NflRushing.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias NflRushing.Repo
alias NflRushing.DataConverter
alias NflRushing.Statistics.FootballPlayer

{:ok, body} = File.read("priv/repo/rushing.json")
players = Jason.decode!(body)

for player <- players do
  IO.inspect(player, label: "player")

  FootballPlayer.changeset(
    %FootballPlayer{},
    %{
      player: player["Player"],
      team: player["Team"],
      pos: player["Pos"],
      att_g: player["Att/G"],
      att: player["Att"],
      yds: DataConverter.to_numeric(player["Yds"]),
      avg: player["Avg"],
      yds_g: player["Yds/G"],
      td: player["TD"],
      lng: DataConverter.to_string(player["Lng"]),
      first_down: player["1st"],
      first_down_porcent: player["1st%"],
      twenty_plus: player["20+"],
      forty_plus: player["40+"],
      fum: player["FUM"]
    }
  )
  |> Repo.insert!()
end
