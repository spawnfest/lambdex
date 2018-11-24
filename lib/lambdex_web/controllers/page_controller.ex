defmodule LambdexWeb.PageController do
  use LambdexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
