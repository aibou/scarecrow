require 'spec_helper'
require 'rack/test'


describe Scarecrow::Server do
  include Rack::Test::Methods
  
  def app
    hash = YAML.load <<EOYAML
/:
  GET:
    - request:
        headers:
          authorization: OAuth abcdef00token
      response:
        body: "valid token"
    - request:
        headers:
          authorization: OAuth xxxxxx00token
      response:
        body: "invalid token"
        status: 401
EOYAML
    Scarecrow::Server.define(hash)
  end
  
  context 'define "GET /" and need authorization header' do
    context 'GET / with authorization header' do
      context 'with valid token' do
        subject { get('/', header('Authorization', 'OAuth abcdef00token')); last_response }
        it { should be_ok }
        its(:body) { should eq 'valid token' }
      end

      context 'with invalid token' do
        subject { get('/', header('Authorization', 'OAuth xxxxxx00token')); p last_response.headers; last_response }
        it { should be_unauthorized }
        its(:body) { should eq 'invalid token' }
      end
    end

    context 'GET / without header' do
      subject { get '/'; last_response }
      it { should be_not_found }
      its(:headers) { should include({'X-Scarecrow-Status' => 'No such pattern'}) }
    end
  end
end
