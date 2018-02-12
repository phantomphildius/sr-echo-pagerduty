require 'alexa/response'

RSpec.describe Alexa::Response do
  describe '#build' do
    it 'returns a custom json response' do
      custom_res = {
        version: '1.0',
        sessionAttributes: { id: 'sessionId' },
        response: {
          outputSpeech: {
            type: 'PlainText',
            text: 'custom repsonse'
          }
        }
      }.to_json

      expect(Alexa::Response.build('custom repsonse', id: 'sessionId')).to eq(custom_res)
    end
  end
end
