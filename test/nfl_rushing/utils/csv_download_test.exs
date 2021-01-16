defmodule NflRushing.Utils.CsvDownloadTest do
  use ExUnit.Case

  alias NflRushing.Utils.CsvDownload

  @download_path "priv/static/downloads"

  test "create_file/1 check if file was created" do
    CsvDownload.create_file("test")
    assert true == File.exists?("#{@download_path}/test.csv")
  end

  test "remove_file/1 check if file was removed" do
    CsvDownload.create_file("test")
    CsvDownload.remove_file("test")
    assert false == File.exists?("#{@download_path}/test.csv")
  end
end
