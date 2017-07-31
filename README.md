# sr-echo-pagerduty
SimpleReach PagerDuty app for Amazon Echo

## Usage
Currently in dev
* Will require pagerduty token. Token will be stored in amazon's dynamoDB, hidden through gem devise

## Current Endpoints
### incidents
* Alexa reads back all triggered incidents sorted by desc date
### oncalls
* Alexa responds with current team members on call sorted by priority
### in dev
* Respond to an alert
  
## Tests
* Run rspec spec
