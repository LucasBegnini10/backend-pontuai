defmodule PhxWeb.Router do
  use PhxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PhxWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Phx.Plug.Authenticate
  end

  #PUBLIC
  scope "/api/v1", PhxWeb do
    pipe_through :api


    post "/accounts/auth", AccountController, :auth
    post "/accounts", AccountController, :create
  end


  #AUTH
  scope "/api/v1", PhxWeb do
    pipe_through [:api, :auth]

    patch "/accounts/:user_id", AccountController, :update
    # delete "/accounts/:id", AccountController, :delete
  end


  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:phx, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PhxWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
