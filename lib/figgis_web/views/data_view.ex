defmodule FiggisWeb.DataView do
  use FiggisWeb, :view

  alias Figgis.Metrics.Datum

  def render("datum.json", %{datum: datum}) do
    %{
      xValue: datum.x_value,
      yValue: datum.y_value
    }
  end
end
