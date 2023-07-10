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
    plug Phx.Config.Authenticate
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :phx, swagger_file: "swagger.json"
  end

  # PUBLIC
  scope "/api/v1", PhxWeb do
    pipe_through :api

    post "/users/auth", UserController, :auth
    post "/users", UserController, :create
  end

  # AUTH
  scope "/api/v1", PhxWeb do
    pipe_through [:api, :auth]

    get "/users/:user_id", UserController, :get_user
    patch "/users/:user_id", UserController, :update
    get "/users/:user_id/points", UserController, :get_points
    delete "/users/:user_id", UserController, :delete_user

    post "/awards", AwardController, :create
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

  def swagger_info do
    %{
      schemes: ["http", "https"],
      info: %{
        version: "1.0",
        title: "Pontuai API",
        description: "API Documentation for Pontuai v1",
        termsOfService: "Open for public",
        contact: %{
          name: "Lucas Begnini",
          email: "begninilucas12@gmail.com"
        }
      },
      securityDefinitions: %{
        Bearer: %{
          type: "apiKey",
          name: "Authorization",
          description: "API Token must be provided via `Authorization: Bearer {token}",
          in: "header"
        }
      },
      consumes: ["application/json"],
      produces: ["application/json"],
      tags: [
        %{name: "Users", description: "User resources"}
      ]
    }
  end
end
