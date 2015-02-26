require 'spec_helper'
require 'rack/test'


describe Scarecrow::Server do
  include Rack::Test::Methods
  
  def app
    hash = YAML.load <<EOYAML
"/hello":
  method: GET
  patterns:
    - response:
        body: "hello"
"/bye":
  method: GET
  patterns:
    - response:
        body: "bye"
EOYAML
    Scarecrow::Server.define(hash)
  end
  
  context 'define multi pathes' do
    context 'GET /hello' do
      subject { get '/hello'; last_response }
      it { should be_ok }
      its(:body) { should eq 'hello' }
    end

    context 'GET /bye' do
      subject { get '/bye'; last_response }
      it { should be_ok }
      its(:body) { should eq 'bye' }
    end
  end
end
