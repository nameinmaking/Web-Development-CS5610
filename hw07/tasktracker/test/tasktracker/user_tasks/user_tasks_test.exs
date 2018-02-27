defmodule Tasktracker.UserTasksTest do
  use Tasktracker.DataCase

  alias Tasktracker.UserTasks

  describe "tasks" do
    alias Tasktracker.UserTasks.Task

    @valid_attrs %{complete: true, description: "some description", title: "some title"}
    @update_attrs %{complete: false, description: "some updated description", title: "some updated title"}
    @invalid_attrs %{complete: nil, description: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserTasks.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert UserTasks.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert UserTasks.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = UserTasks.create_task(@valid_attrs)
      assert task.complete == true
      assert task.description == "some description"
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserTasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = UserTasks.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.complete == false
      assert task.description == "some updated description"
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = UserTasks.update_task(task, @invalid_attrs)
      assert task == UserTasks.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = UserTasks.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> UserTasks.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = UserTasks.change_task(task)
    end
  end

  describe "sprintcycle" do
    alias Tasktracker.UserTasks.Sprintcycle

    @valid_attrs %{end_time: ~N[2010-04-17 14:00:00.000000], start: true, start_time: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{end_time: ~N[2011-05-18 15:01:01.000000], start: false, start_time: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{end_time: nil, start: nil, start_time: nil}

    def sprintcycle_fixture(attrs \\ %{}) do
      {:ok, sprintcycle} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserTasks.create_sprintcycle()

      sprintcycle
    end

    test "list_sprintcycle/0 returns all sprintcycle" do
      sprintcycle = sprintcycle_fixture()
      assert UserTasks.list_sprintcycle() == [sprintcycle]
    end

    test "get_sprintcycle!/1 returns the sprintcycle with given id" do
      sprintcycle = sprintcycle_fixture()
      assert UserTasks.get_sprintcycle!(sprintcycle.id) == sprintcycle
    end

    test "create_sprintcycle/1 with valid data creates a sprintcycle" do
      assert {:ok, %Sprintcycle{} = sprintcycle} = UserTasks.create_sprintcycle(@valid_attrs)
      assert sprintcycle.end_time == ~N[2010-04-17 14:00:00.000000]
      assert sprintcycle.start == true
      assert sprintcycle.start_time == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_sprintcycle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserTasks.create_sprintcycle(@invalid_attrs)
    end

    test "update_sprintcycle/2 with valid data updates the sprintcycle" do
      sprintcycle = sprintcycle_fixture()
      assert {:ok, sprintcycle} = UserTasks.update_sprintcycle(sprintcycle, @update_attrs)
      assert %Sprintcycle{} = sprintcycle
      assert sprintcycle.end_time == ~N[2011-05-18 15:01:01.000000]
      assert sprintcycle.start == false
      assert sprintcycle.start_time == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_sprintcycle/2 with invalid data returns error changeset" do
      sprintcycle = sprintcycle_fixture()
      assert {:error, %Ecto.Changeset{}} = UserTasks.update_sprintcycle(sprintcycle, @invalid_attrs)
      assert sprintcycle == UserTasks.get_sprintcycle!(sprintcycle.id)
    end

    test "delete_sprintcycle/1 deletes the sprintcycle" do
      sprintcycle = sprintcycle_fixture()
      assert {:ok, %Sprintcycle{}} = UserTasks.delete_sprintcycle(sprintcycle)
      assert_raise Ecto.NoResultsError, fn -> UserTasks.get_sprintcycle!(sprintcycle.id) end
    end

    test "change_sprintcycle/1 returns a sprintcycle changeset" do
      sprintcycle = sprintcycle_fixture()
      assert %Ecto.Changeset{} = UserTasks.change_sprintcycle(sprintcycle)
    end
  end
end
