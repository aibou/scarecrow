require 'spec_helper'
require 'rack/test'


describe Scarecrow::Server do
  include Rack::Test::Methods
  
  def app
    hash = YAML.load <<EOYAML
"/":
  method: GET
  patterns:
    - response:
        body: "get"
"/":
  method: POST
  patterns:
    - response:
        body: "post"
EOYAML
    Scarecrow::Server.define(hash)
  end
  
  context 'define "GET /" and "POST /"' do
    context 'GET /' do
      subject { get '/'; last_response }
      it { should be_ok }
      its(:body) { should eq 'get' }
    end

    context 'POST /' do
      subject { post '/'; last_response }
      it { should be_ok }
      its(:body) { should eq 'post' }
    end
  end
end
