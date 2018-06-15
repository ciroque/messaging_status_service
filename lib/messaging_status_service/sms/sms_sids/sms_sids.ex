defmodule MessagingStatusService.Sms.SmsSids do
  import Ecto.Query, warn: false

  alias MessagingStatusService.SmsSid
  alias MessagingStatusService.Repo

  def create(attrs \\ %{}) when is_map(attrs) do
    %SmsSid{}
    |> SmsSid.changeset(attrs)
    |> Repo.insert
  end

  def get!(id) do
    Repo.get!(SmsSid, id)
  end
end
