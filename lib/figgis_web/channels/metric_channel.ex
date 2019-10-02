defmodule FiggisWeb.MetricChannel do
  @moduledoc false

  use FiggisWeb, :channel

  alias Figgis.Metrics

  alias FiggisWeb.DataView

  import Phoenix.View, only: [render_many: 4]

  def join("metric:" <> metric_id, params, socket) do
    try do
      metric = Metrics.get_metric!(metric_id)

      send(self(), {:after_join, params})

      {:ok, assign(socket, :metric_id, metric.id)}
    rescue
      Ecto.NoResultsError ->
        {:error, %{reason: "unrecognized metric"}}
    end
  end

  def handle_info({:after_join, _params}, socket) do
    metric = Metrics.get_metric!(socket.assigns[:metric_id])
    data = Metrics.list_data(metric)

    push(socket, "data", %{data: render_data(data)})

    {:noreply, socket}
  end

  defp render_data(data) do
    render_many(data, DataView, "datum.json", as: :datum)
  end

  # Add authorization logic here as required.
  # defp authorized?(_payload) do
  #  true
  # end
end
