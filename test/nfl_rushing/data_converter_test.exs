defmodule NflRushing.DataConverterTest do
  use NflRushing.DataCase

  alias NflRushing.DataConverter

  describe "to_numeric" do
    test "when value is string it need to change to float" do
      assert 1.043 == DataConverter.to_numeric("1,043")
      assert 1.0 == DataConverter.to_numeric("1,0")
      assert 1.0 == DataConverter.to_numeric("1.0")
      assert 839 == DataConverter.to_numeric("839")
    end

    test "when value is float it need to return the value" do
      assert 1.043 == DataConverter.to_numeric(1.043)
      assert 1.0 == DataConverter.to_numeric(1.0)
      assert 839 == DataConverter.to_numeric(839)
    end
  end

  describe "to_string" do
    test "when value is numeric it need to change to string" do
      assert "1.043" == DataConverter.to_string(1.043)
      assert "839" == DataConverter.to_string(839)
    end

    test "when value is string it need to return the value" do
      assert "1.043" == DataConverter.to_string("1.043")
    end
  end
end
