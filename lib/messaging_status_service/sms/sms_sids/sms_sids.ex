defmodule MessagingStatusService.Sms.SmsSids do
  import Ecto.Query, warn: false

  alias MessagingStatusService.Sms.SmsSid
  alias MessagingStatusService.Repo

  def create(attrs \\ %{}) do
    %SmsSid{}
    |> SmsSid.changeset(attrs)
    |> Repo.insert
  end

  def get!(id) do
    Repo.get!(SmsSid, id)
  end
end
