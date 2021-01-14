defmodule NflRushing.DataConverter do
  @spec to_numeric(binary()) :: float() | number() | nil
  def to_numeric(val) when is_binary(val),
    do: _to_numeric(Regex.replace(~r{[^\d\.]}, val, "."))

  @spec to_numeric(number()) :: float() | number() | nil
  def to_numeric(val) when is_number(val), do: val

  defp _to_numeric(val) when is_binary(val),
    do: _to_numeric(Integer.parse(val), val)

  defp _to_numeric(:error, _val), do: nil
  defp _to_numeric({num, ""}, _val), do: num
  defp _to_numeric({num, ".0"}, _val), do: num
  defp _to_numeric({_num, _str}, val), do: elem(Float.parse(val), 0)

  @spec to_string(binary | integer) :: binary
  def to_string(value) when is_integer(value), do: Integer.to_string(value)

  @spec to_string(float()) :: binary()
  def to_string(value) when is_float(value), do: Float.to_string(value)

  @spec to_string(binary()) :: binary()
  def to_string(value) when is_binary(value), do: value
end
