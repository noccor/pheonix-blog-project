defmodule Pxblog.PostsController do
  use Pxblog.Web, :controller

  alias Pxblog.Posts

  def index(conn, _params) do
    posts = Repo.all(Posts)
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Posts.changeset(%Posts{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"posts" => posts_params}) do
    changeset = Posts.changeset(%Posts{}, posts_params)

    case Repo.insert(changeset) do
      {:ok, posts} ->
        conn
        |> put_flash(:info, "Posts created successfully.")
        |> redirect(to: posts_path(conn, :show, posts))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    posts = Repo.get!(Posts, id)
    render(conn, "show.html", posts: posts)
  end

  def edit(conn, %{"id" => id}) do
    posts = Repo.get!(Posts, id)
    changeset = Posts.changeset(posts)
    render(conn, "edit.html", posts: posts, changeset: changeset)
  end

  def update(conn, %{"id" => id, "posts" => posts_params}) do
    posts = Repo.get!(Posts, id)
    changeset = Posts.changeset(posts, posts_params)

    case Repo.update(changeset) do
      {:ok, posts} ->
        conn
        |> put_flash(:info, "Posts updated successfully.")
        |> redirect(to: posts_path(conn, :show, posts))
      {:error, changeset} ->
        render(conn, "edit.html", posts: posts, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    posts = Repo.get!(Posts, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(posts)

    conn
    |> put_flash(:info, "Posts deleted successfully.")
    |> redirect(to: posts_path(conn, :index))
  end
end
