require 'alexa/request'

RSpec.describe Alexa::Request do
  describe '#intent_name' do
    it 'returns the intent' do
      sinatra_request = double('Sinatra::Request', body: StringIO.new(request_json))

      expect(Alexa::Request.new(sinatra_request).intent_name).to eq('IntentName')
    end
  end

  describe '#user_id' do
    it 'returns the users id' do
      sinatra_request = double('Sinatra::Request', body: StringIO.new(request_json))

      expect(Alexa::Request.new(sinatra_request).user_id).to eq('user id')
    end
  end

  describe '#slot_value' do
    it 'returns the value for a specified slot' do
      sinatra_request = double('Sinatra::Request', body: StringIO.new(request_json))

      expect(Alexa::Request.new(sinatra_request).slot_value('SlotName')).to eq('10')
    end
  end

  # rubocop:disable Metrics/MethodLength
  def request_json
    {
      'request': {
        'type': 'IntentRequest',
        'intent': {
          'name': 'IntentName',
          'slots': {
            'SlotName': {
              'name': 'SlotName',
              'value': '10'
            }
          }
        }
      },
      'session': {
        'user': {
          userId: 'user id'
        }
      }
    }.to_json
  end
  # rubocop:enable Metrics/MethodLength
end
