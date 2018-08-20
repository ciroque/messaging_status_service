defmodule MessagingStatusService.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(MessagingStatusService.Repo, []),
      supervisor(MessagingStatusServiceWeb.Endpoint, []),
    ]
    ++ ecto_based_calls_workers()
    ++ ecto_based_sms_workers()

    opts = [strategy: :one_for_one, name: MessagingStatusService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    MessagingStatusServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp ecto_based_calls_workers() do
    [
      {Honeydew.EctoPollQueue, [:call_sid_handler, schema: MessagingStatusService.Calls.CallSid, repo: MessagingStatusService.Repo]},
      {Honeydew.Workers, [:call_sid_handler, MessagingStatusService.Calls.HoneydewEctoCallCompletedWorker]}
    ]
  end

  defp ecto_based_sms_workers() do
    [
      {Honeydew.EctoPollQueue, [:sms_sid_handler, schema: MessagingStatusService.Sms.SmsSid, repo: MessagingStatusService.Repo]},
      {Honeydew.Workers, [:sms_sid_handler, MessagingStatusService.Sms.HoneydewEctoSmsCompletedWorker]}
    ]
  end
end
