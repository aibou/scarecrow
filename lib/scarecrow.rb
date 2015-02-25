require 'scarecrow/version'
require 'scarecrow/server'
require 'scarecrow/validator'
require 'scarecrow/parser'

module Scarecrow
  def self.run
    # eat yaml file
    options = Scarecrow::Parser.parse_option
    hash = {
      "hello" => {
        "method" => "GET",
        "patterns" => [
          {
            "request" => {
              "params" => {
                "name" => "Tom"
              }
            },
            "response" => {
              "body" => "hello, Tom!"
            }
          },
          {
            "request" => {
              "params" => {
                "name" => "Bob"
              }
            },
            "response" => {
              "body" => "Who are you? I don't know such name"
            }
          }
        ]
      }
    }
    
    # validate hash

    Scarecrow::Server.run hash, options
  end
end
