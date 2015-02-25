if RUBY_VERSION >= '1.9'
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end
  
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'scarecrow'
