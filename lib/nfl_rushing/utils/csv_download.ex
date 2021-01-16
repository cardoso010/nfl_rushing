defmodule NflRushing.Utils.CsvDownload do
  alias NflRushing.Repo
  alias NflRushing.Statistics

  @download_path "priv/static/downloads/"

  def create_file(filename) do
    File.mkdir_p(Path.dirname(@download_path))
    File.open!("#{@download_path}#{filename}.csv", [:write, :utf8])
  end

  @doc """
  Generate csv from database and using criteria to filter data
  """
  def generate_csv(criteria, filename \\ "player") when is_list(criteria) do
    file = create_file(filename)

    {:ok, stream} = Statistics.get_stream_from_football_players(criteria)

    Repo.transaction(fn ->
      stream
      |> Stream.map(&build_csv_row/1)
      |> concat_stream()
      |> CSV.encode()
      |> Enum.each(&IO.write(file, &1))
    end)
  end

  @doc """
  Remove file after download
  """
  def remove_file(filename) do
    file_path = "#{@download_path}#{filename}.csv"

    if File.exists?(file_path) do
      File.rm_rf!(file_path)
    end
  end

  defp concat_stream(stream) do
    build_first_row_of_csv() |> Stream.concat(stream)
  end

  defp build_first_row_of_csv do
    [
      [
        "Player",
        "Team",
        "Pos",
        "Att/G",
        "Att",
        "Yds",
        "Avg",
        "Yds/G",
        "Td",
        "Lng",
        "1st",
        "1st%",
        "20+",
        "40+",
        "FUM"
      ]
    ]
  end

  defp build_csv_row(player) do
    [
      player.player,
      player.team,
      player.pos,
      player.att_g,
      player.att,
      player.yds,
      player.avg,
      player.yds_g,
      player.td,
      player.lng,
      player.first_down,
      player.first_down_porcent,
      player.twenty_plus,
      player.forty_plus,
      player.fum
    ]
  end
end
