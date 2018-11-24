defmodule LambdexServerWeb.PageController do
  use LambdexServerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
