require 'rubygems'
require 'bundler/setup'

require 'sinatra/base'
require 'haml'
require 'open-uri'
require 'uri'
require 'awesome_print'


# TODO implement real proxy with passing through all headers etc.


BACKEND_HOST = 'http://localhost:5000'
SERVICE_MAPPINGS = {
  'employee-list' => 'http://localhost:5100/employees'
}

class HtmlAssembler < Sinatra::Base
  
  set :server, :thin
  
  get '*' do
    # Forward request to backend
    begin
      source = open("#{BACKEND_HOST}#{request.env['REQUEST_URI']}")
    rescue OpenURI::HTTPError
      return [404, {}, "Not Found"]
    end
    tpl = source.read

    # {{[^{}]+}}
    tags = tpl.scan(/{{[^{}]+}}/)
    tags.each do |tag|
      tag = tag.gsub('{{', '').gsub('}}', '')
      service, query = tag.split('?')

      next unless SERVICE_MAPPINGS.has_key?(service)
      service_html = open("#{SERVICE_MAPPINGS[service]}?#{query}").read

      tpl.gsub!(/{{#{Regexp.escape(tag)}}}/, service_html)
    end

    tpl
  end
  
end
