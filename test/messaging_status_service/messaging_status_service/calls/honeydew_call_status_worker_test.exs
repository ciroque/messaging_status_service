defmodule MessagingStatusService.Calls.HoneydewCallCompletedWorkerTest do
  use ExUnit.Case

  import Mox

  alias MessagingStatusService.LogSourceMock
  alias MessagingStatusService.Calls.DataSourceSinkMock
  alias MessagingStatusService.Calls.CallCompletedHandlerMock
  alias MessagingStatusService.Calls.ErrorSinkMock
  alias MessagingStatusService.Calls.HoneydewCallCompletedWorker

  @expected_call_sid "ABCD1234"

  setup do
    Logger.disable(self())
    verify_on_exit!()
  end

  test "true is true" do
    assert true == true
  end

  test "Call status is completes on first retrieval" do
    expected_call_log = %{"CallSid" => @expected_call_sid , "status" => "completed"}
    LogSourceMock
    |> expect(
      :retrieve_call_log,
      fn actual_call_sid ->
        assert actual_call_sid == @expected_call_sid
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

    HoneydewCallCompletedWorker.handle_call_completed(expected_call_log, [])
  end

  test "request is requeued if the call status is not completed" do
    expected_call_log = %{"CallSid" => @expected_call_sid}
    LogSourceMock
    |> expect(
      :retrieve_call_log,
      fn actual_call_sid ->
        assert actual_call_sid == @expected_call_sid
        {:ok, :in_progress, expected_call_log}
      end
    )

    CallCompletedHandlerMock
    |> expect(:handle_call_completed, fn actual_call_log ->
      assert actual_call_log == expected_call_log
      :ok
    end)

    HoneydewCallCompletedWorker.handle_call_completed(expected_call_log, [])
  end

  test "call log lookup results in error" do
    expected_call_log = %{"CallSid" => @expected_call_sid, "status" => "completed"}
    LogSourceMock |> expect(:retrieve_call_log, fn _id -> {:error, :not_found} end)
    ErrorSinkMock |> expect(:error, fn msg ->
      assert msg =~ ":not_found"
      assert msg =~ @expected_call_sid
    end)
    HoneydewCallCompletedWorker.handle_call_completed(expected_call_log, [])
  end
end
