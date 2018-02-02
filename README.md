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
* Respond to an alert in a session
* Respond to last alert

## Tests
* Run rspec spec

## Dev
* DynamoDB
** https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html
** Download the US-West version and follow the instructions
** table name is users

## TODO
- [ ] write moat tests
- [ ] fix rubocop
- [ ] sandi metz-ify
- [ ] add coveralls
- [ ] elastic beanstalk
- [ ] last alert response
- [ ] session alert response
- [ ] index of triggered alerts
- [ ] investigate login/email/token UI from alexa app
