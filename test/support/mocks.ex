Mox.defmock(
  MessagingStatusService.Calls.CallCompletedHandlerMock,
  for: MessagingStatusService.Calls.CallCompletedHandlerBehaviour)

Mox.defmock(
  MessagingStatusService.Sms.SmsCompletedHandlerMock,
  for: MessagingStatusServiceWeb.Sms.SmsCompletedHandlerBehaviour)

Mox.defmock(
  MessagingStatusService.LogSourceMock,
  for: MessagingStatusService.LogSourceBehaviour)

Mox.defmock(
  MessagingStatusService.Calls.DataSourceSinkMock,
  for: MessagingStatusService.Calls.DataSourceSinkBehaviour)

Mox.defmock(
  MessagingStatusService.Calls.HttpClientMock,
  for: MessagingStatusService.Calls.HttpClientBehaviour)

Mox.defmock(
  MessagingStatusService.Calls.ErrorSinkMock,
  for: MessagingStatusService.Calls.ErrorSinkBehaviour)
