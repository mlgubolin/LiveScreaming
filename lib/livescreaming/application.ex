defmodule Livescreaming.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LivescreamingWeb.Telemetry,
      Livescreaming.Repo,
      {DNSCluster, query: Application.get_env(:livescreaming, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Livescreaming.PubSub},
      # Start a worker by calling: Livescreaming.Worker.start_link(arg)
      # {Livescreaming.Worker, arg},
      # Start to serve requests, typically the last entry
      LivescreamingWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Livescreaming.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LivescreamingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
