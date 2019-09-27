defmodule FiggisWeb.Api.DataView do
  use JSONAPI.View, type: "datum"

  def fields do
    [:x_value, :y_value]
  end

  def render("error.json", %{data: changeset}) do
    FiggisWeb.Api.ChangesetView.invalid_record(changeset)
  end
end
