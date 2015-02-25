require 'spec_helper'
require 'rack/test'


describe Scarecrow::Server do
  include Rack::Test::Methods
  
  def app
    hash = YAML.load_file 'sample/hello.yaml'
    Scarecrow::Server.run(hash)
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
  end
end
