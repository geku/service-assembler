require 'rubygems'
require 'bundler/setup'

require 'sinatra/base'
require 'awesome_print'

require './renderer'


# TODO implement real proxy with passing through all headers etc.
# TODO ensure multiple services are fetched in parallel. 
# => We need to provide one command to request multiple backend results.
# TODO allow requesting same service multiple times without adding it multiple times to mapping

BACKEND_HOST = 'http://localhost:5000'
SERVICE_MAPPINGS = {
  'employees' => 'http://localhost:5100/employees.json',
  'agents' => 'http://localhost:5100/employees.json',
}

class HtmlAssembler < Sinatra::Base

  @@renderer = Renderer.new(SERVICE_MAPPINGS)

  helpers do
    def render_template(tpl)
      @@renderer.render(tpl, params)
    end
  end
  
  set :server, :thin
  
  get '*' do
    # Forward request to backend
    begin
      source = open("#{BACKEND_HOST}#{request.env['REQUEST_URI']}")
    rescue OpenURI::HTTPError
      return [404, {}, "Not Found"]
    end

    # TODO only render responses of type HTML through our render engine (don't for images, JS, etc.)

    tpl = source.read
    render_template(tpl)
  end
  
end
