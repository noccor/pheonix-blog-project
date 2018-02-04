defmodule Pxblog.PostsTest do
  use Pxblog.ModelCase

  alias Pxblog.Posts

  @valid_attrs %{body: "some body", title: "some title"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Posts.changeset(%Posts{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Posts.changeset(%Posts{}, @invalid_attrs)
    refute changeset.valid?
  end
end
