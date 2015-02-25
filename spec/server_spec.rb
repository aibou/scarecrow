require 'spec_helper'
require 'rack/test'


describe Scarecrow::Server do
  include Rack::Test::Methods
  
  def app
    hash = YAML.load_file 'sample/hello.yaml'
    Scarecrow::Server.run(hash)
  end
  
  describe '.run' do
    it 'hello' do
      get '/hello', name: 'Tom'
      expect(last_response).to be_ok
      expect(last_response.body).to eq 'Hello, Tom!'
    end
  end
end
