defmodule FiggisWeb.MetricController do
  use FiggisWeb, :controller

  alias Figgis.{Projects, Metrics}
  alias Metrics.Metric

  plug :find_project

  defp find_project(conn, _) do
    project = Projects.get_project!(conn.params["project_id"])

    assign(conn, :project, project)
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.project]

    apply(__MODULE__, action_name(conn), args)
  end

  def new(conn, _params, project) do
    changeset = Metrics.change_metric(%Metric{})
    render(conn, "new.html", changeset: changeset, project: project)
  end

  def create(conn, %{"metric" => metric_params}, project) do
    case Metrics.create_metric(project, metric_params) do
      {:ok, metric} ->
        conn
        |> put_flash(:info, "Metric created successfully")
        |> redirect(to: Routes.project_metric_path(conn, :show, project, metric))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, project) do
    metric = Metrics.get_metric!(id)

    render(conn, "show.html", project: project, metric: metric)
  end

  def edit(conn, %{"id" => id}, project) do
    metric = Metrics.get_metric!(id)
    changeset = Metrics.change_metric(metric)

    render(conn, "edit.html", project: project, metric: metric, changeset: changeset)
  end

  def update(conn, %{"id" => id, "metric" => metric_params}, project) do
    metric = Metrics.get_metric!(id)

    case Metrics.update_metric(project, metric, metric_params) do
      {:ok, metric} ->
        conn
        |> put_flash(:info, "Metric updated successfully.")
        |> redirect(to: Routes.project_metric_path(conn, :show, project, metric))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", project: project, metric: metric, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, project) do
    metric = Metrics.get_metric!(id)
    {:ok, _metric} = Metrics.delete_metric(metric)

    conn
    |> put_flash(:info, "Metric deleted successfully.")
    |> redirect(to: Routes.project_path(conn, :show, project))
  end
end
