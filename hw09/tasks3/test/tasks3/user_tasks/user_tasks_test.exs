defmodule Tasks3.UserTasksTest do
  use Tasks3.DataCase

  alias Tasks3.UserTasks

  describe "tasks" do
    alias Tasks3.UserTasks.Task

    @valid_attrs %{completed: true, description: "some description", time_spent: 42, title: "some title"}
    @update_attrs %{completed: false, description: "some updated description", time_spent: 43, title: "some updated title"}
    @invalid_attrs %{completed: nil, description: nil, time_spent: nil, title: nil}

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
      assert task.completed == true
      assert task.description == "some description"
      assert task.time_spent == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserTasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = UserTasks.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completed == false
      assert task.description == "some updated description"
      assert task.time_spent == 43
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
