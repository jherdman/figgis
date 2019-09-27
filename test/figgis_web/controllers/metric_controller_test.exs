defmodule FiggisWeb.MetricControllerTest do
  use FiggisWeb.ConnCase

  alias Figgis.Factory

  @create_attrs %{
    name: "CSS Bundle Size",
    description: "Tracks bundle size of CSS over time",
    x_axis_label: "Time",
    x_axis_type: "date",
    y_axis_label: "Kilobytes",
    y_axis_type: "number"
  }

  @invalid_attrs %{}

  @update_attrs %{
    name: "CSS Package Size",
    description: "Tracks package size of CSS over time",
    x_axis_label: "Deploy date",
    x_axis_type: "date",
    y_axis_label: "Bytes",
    y_axis_type: "number"
  }

  setup do
    project = Factory.insert(:project)

    {:ok, project: project}
  end

  describe "new metric" do
    test "renders form", %{conn: conn, project: project} do
      conn = get(conn, Routes.project_metric_path(conn, :new, project))
      assert html_response(conn, 200) =~ "New #{project.name} Metric"
    end
  end

  describe "create metric" do
    test "redirects to show when data is valid", %{conn: conn, project: project} do
      conn = post(conn, Routes.project_metric_path(conn, :create, project), metric: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.project_metric_path(conn, :show, project, id)

      conn = get(conn, Routes.project_metric_path(conn, :show, project, id))
      assert html_response(conn, 200) =~ @create_attrs.name
    end

    test "renders errors when data is invalid", %{conn: conn, project: project} do
      conn =
        post(conn, Routes.project_metric_path(conn, :create, project), metric: @invalid_attrs)

      assert html_response(conn, 200) =~ "New #{project.name} Metric"
    end
  end

  describe "update metric" do
    setup [:create_metric]

    test "redirects when data is valid", %{conn: conn, metric: metric, project: project} do
      conn =
        put(conn, Routes.project_metric_path(conn, :update, project, metric),
          metric: @update_attrs
        )

      assert redirected_to(conn) == Routes.project_metric_path(conn, :show, project, metric)

      conn = get(conn, Routes.project_metric_path(conn, :show, project, metric))
      assert html_response(conn, 200) =~ @update_attrs.name
    end

    test "renders errors when data is invalid", %{conn: conn, metric: metric, project: project} do
      conn =
        put(conn, Routes.project_metric_path(conn, :update, project, metric),
          metric: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit #{metric.name}"
    end
  end

  describe "delete metric" do
    setup [:create_metric]

    test "deletes chosen metric", %{conn: conn, metric: metric, project: project} do
      conn = delete(conn, Routes.project_metric_path(conn, :delete, project, metric))
      assert redirected_to(conn) == Routes.project_path(conn, :show, project)

      assert_error_sent 404, fn ->
        get(conn, Routes.project_metric_path(conn, :show, project, metric))
      end
    end
  end

  defp create_metric(_) do
    metric = Factory.insert(:metric)

    {:ok, metric: metric, project: metric.project}
  end
end
