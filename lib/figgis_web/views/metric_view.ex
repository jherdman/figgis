defmodule FiggisWeb.MetricView do
  use FiggisWeb, :view

  @doc """
  Returns a list of tuples to be used with Phoenix.HTML.Form.select/4

  ## Examples

      iex> FiggisWeb.MetricView.axis_type_options()
      [{"Date", "date"}, {"Number", "number"}]
  """
  def axis_type_options do
    AxisTypes.__enum_map__()
    |> Enum.map(&Atom.to_string/1)
    |> Enum.sort()
    |> Enum.map(fn axis_type ->
      first = String.first(axis_type)
      rest = String.slice(axis_type, 1..-1)

      {
        "#{String.upcase(first)}#{rest}",
        axis_type
      }
    end)
  end

  @doc """
  Returns classes for a column type

  ## Examples

      iex> FiggisWeb.MetricView.datum_row_classes(:date)
      "Td"

      iex> FiggisWeb.MetricView.datum_row_classes(:number)
      "Td Td--mono"
  """
  def datum_row_classes(:number), do: "Td Td--mono"
  def datum_row_classes(_), do: "Td"

  @doc """
  Formats a value for the data table values. This effectively treats a "number"
  as a no-op, but tries to make a date a little more human readable.

  ## Examples

      iex> FiggisWeb.MetricView.format_value(:number, "123")
      "123"

      iex> FiggisWeb.MetricView.format_value(:number, "1234")
      "1234"

      iex> FiggisWeb.MetricView.format_value(:number, "1.23")
      "1.23"

      iex> FiggisWeb.MetricView.format_value(:date, "2019-09-27 10:30:30")
      "Sep 27, 2019, 10:30:30"

      iex> FiggisWeb.MetricView.format_value(:date, "2020-05-16 23:01:00")
      "May 16, 2020, 23:01:00"

      iex> FiggisWeb.MetricView.format_value(:date, "fart")
      "Invalid date"
  """
  def format_value(:number, value), do: value

  def format_value(:date, value) do
    with {:ok, time} <- NaiveDateTime.from_iso8601(value),
         {:ok, formatted} <- Timex.format(time, "{Mshort} {D}, {YYYY}, {h24}:{m}:{s}") do
      formatted
    else
      {:error, _} ->
        "Invalid date"
    end
  end
end
