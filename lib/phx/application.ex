defmodule Phx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhxWeb.Telemetry,
      # Start the Ecto repository
      Phx.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Phx.PubSub},
      # Start Finch
      {Finch, name: Phx.Finch},
      # Start the Endpoint (http/https)
      PhxWeb.Endpoint
      # Start a worker by calling: Phx.Worker.start_link(arg)
      # {Phx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Phx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
