defmodule MessagingStatusService.Application do
  use Application

  alias MessagingStatusService.CallStatusHandling.HoneydewCallStatusWorker

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(MessagingStatusService.Repo, []),
      supervisor(MessagingStatusServiceWeb.Endpoint, []),
      Honeydew.queue_spec(:call_status_handling),
      Honeydew.worker_spec(:call_status_handling, {HoneydewCallStatusWorker, []}, num: 3, init_retry_secs: 13)
    ]

    opts = [strategy: :one_for_one, name: MessagingStatusService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    MessagingStatusServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
