defmodule LiveViewsPlayground.TodosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveViewsPlayground.Todos` context.
  """

  @doc """
  Generate a todo.
  """
  def todo_fixture(attrs \\ %{}) do
    {:ok, todo} =
      attrs
      |> Enum.into(%{
        description: "some description",
        completed: true
      })
      |> LiveViewsPlayground.Todos.create_todo()

    todo
  end
end
