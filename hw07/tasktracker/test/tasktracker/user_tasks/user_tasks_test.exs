defmodule Tasktracker.UserTasksTest do
  use Tasktracker.DataCase

  alias Tasktracker.UserTasks

  describe "tasks" do
    alias Tasktracker.UserTasks.Task

    @valid_attrs %{description: "some description", is_completed: true, title: "some title"}
    @update_attrs %{description: "some updated description", is_completed: false, title: "some updated title"}
    @invalid_attrs %{description: nil, is_completed: nil, title: nil}

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
      assert task.description == "some description"
      assert task.is_completed == true
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserTasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = UserTasks.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.description == "some updated description"
      assert task.is_completed == false
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
end
