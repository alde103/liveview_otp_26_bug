defmodule LiveviewOtp26Bug.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveviewOtp26BugWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveviewOtp26Bug.PubSub},
      # Start Finch
      {Finch, name: LiveviewOtp26Bug.Finch},
      # Start the Endpoint (http/https)
      LiveviewOtp26BugWeb.Endpoint
      # Start a worker by calling: LiveviewOtp26Bug.Worker.start_link(arg)
      # {LiveviewOtp26Bug.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveviewOtp26Bug.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveviewOtp26BugWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
