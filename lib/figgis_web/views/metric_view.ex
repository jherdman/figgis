defmodule FiggisWeb.MetricView do
  use FiggisWeb, :view

  @doc """
  Returns a list of tuples to be used with Phoenix.HTML.Form.select/4

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
end
