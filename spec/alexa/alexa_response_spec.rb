require 'alexa/response'

RSpec.describe Alexa::Response do
  describe '.build' do
    it 'returns a custom json response' do
      custom_res = {
        version: '1.0',
        response: {
          outputSpeech: {
            type: 'PlainText',
            text: 'custom repsonse'
          }
        }
      }.to_json
      expect(Alexa::Response.build('custom repsonse')).to eq(custom_res)
    end
  end
end
