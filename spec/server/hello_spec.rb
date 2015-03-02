require 'spec_helper'
require 'rack/test'


describe Scarecrow::Server do
  include Rack::Test::Methods



  def app
    hash = YAML.load <<EOYAML
hello:
  GET:
    - request:
        params:
          name: "Tom"
      response:
        body: "Hello, Tom!"
    - request:
        params:
          name: "Bob"
      response:
        body: "Who are you? I don't know that name"
EOYAML
    Scarecrow::Server.define(hash)
  end

  context 'sample/hello.yaml' do
    context 'GET /hello?name=Tom' do
      subject { get '/hello', name: 'Tom'; last_response }
      it { should be_ok }
      its(:body) { should eq 'Hello, Tom!' }
    end

    context 'GET /hello?name=Bob' do
      subject { get '/hello', name: 'Bob'; last_response }
      it { should be_ok }
      its(:body) { should eq 'Who are you? I don\'t know that name' }
    end

    context 'GET /hello?name=Aaron' do
      subject { get '/hello', name: 'Aaron'; last_response }
      it { should be_not_found }
      its(:headers) { should include({'X-Scarecrow-Status' => 'No such pattern'}) }
      its(:body) { should eq 'No such pattern' }
    end
  end
end
