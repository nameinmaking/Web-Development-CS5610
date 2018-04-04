defmodule Tasks3.UserTasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
      field :completed, :boolean, default: false
      field :description, :string
      field :time_spent, :integer, default: 0
      field :title, :string
      belongs_to :user, Tasks3.Accounts.User
      belongs_to :creator, Tasks3.Accounts.User

      timestamps()
    end

    @doc false
    def changeset(task, attrs) do
      task
      |> cast(attrs, [:title, :description, :completed, :time_spent, :user_id, :creator_id])
      |> validate_required([:title, :description, :completed, :user_id, :creator_id])
      |> validate_increment(:elapsed_time)
  end

  # REMEBER! Syntax: validate_acceptance(changeset, field, opts \\ [])
  def validate_increment(changeset, field, opts \\ []) do
    validate_change(changeset, field, fn _, elapsed_time ->
      case rem(elapsed_time, 15) == 0 do
        true -> []
        false -> [{field, opts[:message] || "The increment should be a multiple of 15!"}]
      end
    end)
  end
end


# Attribute: https://medium.com/@QuantLayer/writing-custom-validations-for-ecto-changesets-4971881c7684
# The code in the above link was reffered to implement the validate_increment function
