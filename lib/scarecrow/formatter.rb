module Scarecrow
  module Formatter
    def self.format data
      formatted = {}
      
      data.each do |key, value|
        path = File.join('/', key.gsub(/\./, '/'))
        formatted[path] = {}
        value.each do |method, patterns|
          patterns.map! do |pattern|
            pattern.symbolize_keys!
            pattern[:request] ||= {}
            pattern[:request][:params] ||= {}
            pattern[:request][:headers] ||= {}
            pattern[:response] ||= {}
            if pattern[:response][:body].is_a? Hash
              pattern[:response][:headers] ||= {}
              pattern[:response][:headers]['Content-Type'] = 'application/json'
              pattern[:response][:body] = pattern[:response][:body].to_json
            end
            pattern
          end
          formatted[path][method.downcase.to_sym] = patterns
        end
      end
      formatted
    end
  end
end
