if RUBY_VERSION >= '1.9' && ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end
  
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'scarecrow'
require 'rspec/its'
