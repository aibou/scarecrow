require 'spec_helper'
require 'rack/test'


describe Scarecrow::Server do
  include Rack::Test::Methods
  
  def app
    hash = YAML.load <<EOYAML
"/":
  method: GET
  patterns:
    - request:
        headers:
          authorization: OAuth abcdef00token
      response:
        body: "valid token"
EOYAML
    Scarecrow::Server.define(hash)
  end
  
  context 'define "GET /" and need authorization header' do
    context 'GET / with header' do
      subject { get('/', header('Authorization', 'OAuth abcdef00token')); last_response }
      it { should be_ok }
      its(:body) { should eq 'valid token' }
    end

    context 'GET / without header' do
      subject { get '/'; last_response }
      it { should be_not_found }
      its(:headers) { should include({'X-Scarecrow-Status' => 'No such pattern'}) }
    end
  end
end
