defmodule MessagingStatusService.CallStatusHandling.HoneydewCallStatusWorkerTest do
  use ExUnit.Case

  import Mox

  alias MessagingStatusService.CallStatusHandling.DataSourceSinkMock
  alias MessagingStatusService.CallStatusHandling.CallLogSourceMock
  alias MessagingStatusService.CallStatusHandling.CallStatusHandlerMock
  alias MessagingStatusService.CallStatusHandling.HoneydewCallStatusWorker

  setup do
    Logger.disable(self())
    verify_on_exit!()
  end

  test "true is true" do
    assert true == true
  end

  test "Call status is completes on first retrieval" do
    expected_call_sid = "ABCD1234"
    expected_call_log = %{"CallSid" => expected_call_sid, "status" => "completed"}
    CallLogSourceMock
    |> expect(
      :retrieve_call_log,
      fn actual_call_sid ->
        assert actual_call_sid == expected_call_sid
        {:ok, :completed, expected_call_log}
      end
    )

    DataSourceSinkMock
    |> expect(
      :store_call_log,
      fn actual_call_log ->
        assert actual_call_log == expected_call_log
      end
    )

    HoneydewCallStatusWorker.handle_call_status(expected_call_log, [])
  end
end
