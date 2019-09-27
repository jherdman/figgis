defmodule FiggisWeb.Api.DataController do
  use FiggisWeb, :controller

  alias Figgis.Metrics

  plug :find_metric

  defp find_metric(conn, _) do
    metric = Metrics.get_metric!(conn.params["metric_id"])

    assign(conn, :metric, metric)
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.metric]

    apply(__MODULE__, action_name(conn), args)
  end

  def create(conn, %{"data" => %{"attributes" => attributes}}, metric) do
    case Metrics.create_datum(metric, attributes) do
      {:ok, datum} ->
        conn
        |> put_status(:created)
        |> render("show.json", %{data: datum})

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", data: changeset)
    end
  end
end
