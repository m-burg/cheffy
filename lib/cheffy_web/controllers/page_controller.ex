defmodule CheffyWeb.PageController do
  use CheffyWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
