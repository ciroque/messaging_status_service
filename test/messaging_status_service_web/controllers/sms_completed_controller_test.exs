defmodule MessagingStatusServiceWeb.Sms.SmsControllerTest do
  use MessagingStatusServiceWeb.ConnCase

  import Mox

  alias MessagingStatusService.Sms.SmsCompletedHandlerMock

  describe "SmsCompletedController" do
    @sms_sid "ZYXWVUT098765"

    setup do
      verify_on_exit!()
    end

    test "Calls CompletedHandler::handle_completed_sms", %{conn: conn} do
      SmsCompletedHandlerMock |> expect(:handle_sms_completed, fn _ -> :ok end)
      conn = conn |> post(sms_path(conn, :create, %{"SmsSid" => @sms_sid}))
      assert xml_response(conn, :accepted)
    end
  end
end
