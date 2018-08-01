# Messaging Status Service

Near Real Time acquisition of Call / SMS logs. Intended as a clearing house / fan-out system for logs provided by
messaging services such as Twilio. At it's core the service implements two endpoints, one for SMS, the other for 
Calls. It is easy to extend / modify the service to implement other messaging providers. It is also fairly
easy to implement sinks for the log data as well. 


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

- Erlang
- Elixir 1.6
- Phoenix 1.3 or up
- mix

### Installing

**Clone the repo:**

`git clone https://github.com/...`

**Install the dependencies:**

`mix deps.get`

**Start the app:**

`iex[.bat] -S mix phx.server`

**Configure your messaging provider to call the service and report logs:**

This is mostly beyond the scope of this document, but in general you need to let your messaging provider know how to
post logs to the service.

For Twilio this is most easily achieved using the **_action_** attribute available on some of the TwiML tags 
(**_[Voice TwiML](https://www.twilio.com/docs/voice/twiml)_**, **_[SMS TwiML](https://www.twilio.com/docs/sms/twiml)_**). 

## Running the tests

```bash
mix test
```

## Deployment

**_forthcoming_**

(will prolly be via Docker)

## Built With

* [Elixir](https://elixir-lang.org/) 
* [Phoenix Framework](http://phoenixframework.org/)

## Contributing

Please read [CONTRIBUTING.md](/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. 

## Authors

* **Steve Wagner** - *Initial Work* - [ciroque](https://github.com/ciroque)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

# Sample Log

%{
  "AccountSid" => "AC69adbf55f687c6005059f14599cda396", 
  "ApiVersion" => "2010-04-01", 
  "CallSid" => "CAd7a23fec81aa0106867e5ac35ed20200", 
  "CallStatus" => "in-progress", 
  "Called" => "+15713663791", 
  "CalledCity" => "RESTON", 
  "CalledCountry" => "US", 
  "CalledState" => "VA", 
  "CalledZip" => "20191", 
  "Caller" => "+266696687", 
  "CallerCity" => "", 
  "CallerCountry" => "LS", 
  "CallerState" => "", 
  "CallerZip" => "", 
  "DialCallDuration" => "11", 
  "DialCallSid" => "CAfde60e8cd5a7b2e80126988f648fe21b", 
  "DialCallStatus" => "completed", 
  "Direction" => "inbound", 
  "From" => "+266696687", 
  "FromCity" => "", 
  "FromCountry" => "LS", 
  "FromState" => "", 
  "FromZip" => "", 
  "To" => "+15713663791", 
  "ToCity" => "RESTON", 
  "ToCountry" => "US", 
  "ToState" => "VA", 
  "ToZip" => "20191"}





