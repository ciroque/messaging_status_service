defmodule MessagingStatusService.Application do
  use Application

#  alias MessagingStatusService.Calls.HoneydewCallCompletedWorker

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(MessagingStatusService.Repo, []),
      supervisor(MessagingStatusServiceWeb.Endpoint, []),

      ## These entries enable the in-memory :queue based implementation
#      Honeydew.queue_spec(:calls),
#      Honeydew.worker_spec(:calls, {HoneydewCallCompletedWorker, []}, num: 3, init_retry_secs: 13)

#      {Honeydew.EctoPollQueue, [:call_sid_handler, schema: MessagingStatusService.Calls.CallSid, repo: MessagingStatusService.Repo]},
#      {Honeydew.Workers, [:call_sid_handler, MessagingStatusService.Calls.HoneydewEctoCallCompletedWorker]}
    ]

    opts = [strategy: :one_for_one, name: MessagingStatusService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    MessagingStatusServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
