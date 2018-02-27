defmodule TasktrackerWeb.SprintcycleControllerTest do
  use TasktrackerWeb.ConnCase

  alias Tasktracker.UserTasks
  alias Tasktracker.UserTasks.Sprintcycle

  @create_attrs %{end_time: ~N[2010-04-17 14:00:00.000000], start: true, start_time: ~N[2010-04-17 14:00:00.000000]}
  @update_attrs %{end_time: ~N[2011-05-18 15:01:01.000000], start: false, start_time: ~N[2011-05-18 15:01:01.000000]}
  @invalid_attrs %{end_time: nil, start: nil, start_time: nil}

  def fixture(:sprintcycle) do
    {:ok, sprintcycle} = UserTasks.create_sprintcycle(@create_attrs)
    sprintcycle
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sprintcycle", %{conn: conn} do
      conn = get conn, sprintcycle_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create sprintcycle" do
    test "renders sprintcycle when data is valid", %{conn: conn} do
      conn = post conn, sprintcycle_path(conn, :create), sprintcycle: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, sprintcycle_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "end_time" => ~N[2010-04-17 14:00:00.000000],
        "start" => true,
        "start_time" => ~N[2010-04-17 14:00:00.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, sprintcycle_path(conn, :create), sprintcycle: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update sprintcycle" do
    setup [:create_sprintcycle]

    test "renders sprintcycle when data is valid", %{conn: conn, sprintcycle: %Sprintcycle{id: id} = sprintcycle} do
      conn = put conn, sprintcycle_path(conn, :update, sprintcycle), sprintcycle: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, sprintcycle_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "end_time" => ~N[2011-05-18 15:01:01.000000],
        "start" => false,
        "start_time" => ~N[2011-05-18 15:01:01.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn, sprintcycle: sprintcycle} do
      conn = put conn, sprintcycle_path(conn, :update, sprintcycle), sprintcycle: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete sprintcycle" do
    setup [:create_sprintcycle]

    test "deletes chosen sprintcycle", %{conn: conn, sprintcycle: sprintcycle} do
      conn = delete conn, sprintcycle_path(conn, :delete, sprintcycle)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, sprintcycle_path(conn, :show, sprintcycle)
      end
    end
  end

  defp create_sprintcycle(_) do
    sprintcycle = fixture(:sprintcycle)
    {:ok, sprintcycle: sprintcycle}
  end
end
