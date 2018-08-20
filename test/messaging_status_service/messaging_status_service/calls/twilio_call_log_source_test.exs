defmodule TwilioCallLogSourceTest do
  use ExUnit.Case

  import Mox

  alias MessagingStatusService.TwilioLogSource
  alias MessagingStatusService.Calls.HttpClientMock

  @expected_call_sid "ZYXWV09876"

  setup do
    Logger.disable(self())
    verify_on_exit!()
  end

  test "CallSid lookup results in 404" do
    call_log_not_found = {:ok, %{status_code: 404, body: "{\"message\": \"NOT FOUND\"}"}}
    HttpClientMock |> expect(:get, fn _, _, _ -> call_log_not_found end)

    assert {:error, :not_found} == TwilioLogSource.retrieve_call_log(@expected_call_sid)
  end

  test "call log with canceled status yields completed" do
    body = %{"status" => "canceled"}
    call_log = {:ok, %{status_code: 200, body: encode(body)}}
    HttpClientMock |> expect(:get, fn _, _, _ -> call_log end)
    assert {:ok, :completed, body} == TwilioLogSource.retrieve_call_log(@expected_call_sid)
  end

  test "call log with completed status yields completed" do
    body = %{"status" => "completed"}
    call_log = {:ok, %{status_code: 200, body: encode(body) }}
    HttpClientMock |> expect(:get, fn _, _, _ -> call_log end)
    assert {:ok, :completed, body} == TwilioLogSource.retrieve_call_log(@expected_call_sid)
  end

  test "call log with busy status yields completed" do
    body = %{"status" => "busy"}
    call_log = {:ok, %{status_code: 200, body: encode(body)}}
    HttpClientMock |> expect(:get, fn _, _, _ -> call_log end)
    assert {:ok, :completed, body} == TwilioLogSource.retrieve_call_log(@expected_call_sid)
  end

  test "call log with failed status yields completed" do
    body = %{"status" => "failed"}
    call_log = {:ok, %{status_code: 200, body: encode(body)}}
    HttpClientMock |> expect(:get, fn _, _, _ -> call_log end)
    assert {:ok, :completed, body} == TwilioLogSource.retrieve_call_log(@expected_call_sid)
  end

  test "call log with queued status yields in_progress" do
    body = %{"status" => "queued"}
    call_log = {:ok, %{status_code: 200, body: encode(body)}}
    HttpClientMock |> expect(:get, fn _, _, _ -> call_log end)
    assert {:ok, :in_progress, body} == TwilioLogSource.retrieve_call_log(@expected_call_sid)
  end

  test "call log with ringing status yields in_progress" do
    body = %{"status" => "ringing"}
    call_log = {:ok, %{status_code: 200, body: encode(body)}}
    HttpClientMock |> expect(:get, fn _, _, _ -> call_log end)
    assert {:ok, :in_progress, body} == TwilioLogSource.retrieve_call_log(@expected_call_sid)
  end

  test "call log with in-progress status yields in_progress" do
    body = %{"status" => "in-progress"}
    call_log = {:ok, %{status_code: 200, body: encode(body)}}
    HttpClientMock |> expect(:get, fn _, _, _ -> call_log end)
    assert {:ok, :in_progress, body} == TwilioLogSource.retrieve_call_log(@expected_call_sid)
  end

  test "400 response" do
    body = %{"status" => "errored"}
    call_log = {:ok, %{status_code: 400, body: encode(body)}}
    HttpClientMock |> expect(:get, fn _, _, _ -> call_log end)
    assert {:error, body} == TwilioLogSource.retrieve_call_log(@expected_call_sid)
  end

  test "500 response" do
    body = %{"status" => "errored"}
    call_log = {:ok, %{status_code: 500, body: encode(body)}}
    HttpClientMock |> expect(:get, fn _, _, _ -> call_log end)
    assert {:error, body} == TwilioLogSource.retrieve_call_log(@expected_call_sid)
  end

  test "call errors, network segment or something" do
    response = %{"message" => "Network Segmentation, or something like that..."}
    HttpClientMock |> expect(:get, fn _, _, _ -> {:error, response} end)
    assert {:error, response} == TwilioLogSource.retrieve_call_log(@expected_call_sid)
  end

  defp encode(input) do
    Poison.encode!(input)
  end
end
