require 'erb'
require 'cgi'
require 'open-uri'
require 'multi_json'
require 'hashie/mash'

class Renderer

  def initialize(service_mapping = {})
    @service_mapping = service_mapping
  end

  def params
    @params
  end

  def render(template_str, params = {})
    @params = params
    
    tpl = ERB.new(template_str)
    tpl.result(binding)
  end

  private

    # Request data from a JSON backend service
    def load(service, options = {})
      if @service_mapping.has_key?(service)
        query = options.map { |k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }.join('&')
        body = open("#{@service_mapping[service]}?#{query}").read

        # Turn JSON into object
        json_object = MultiJson.load(body)
        service_object = to_service_object(json_object)
        instance_variable_set("@#{service}", service_object)
      else
        puts "WARNING: no service '#{service}' found in registry!"
        # TODO proper error with its own type
        raise "No service '#{service}' found in mapping"
        # instance_variable_set("@#{service}", nil)
      end

    end

    def to_service_object(object)
      if object.is_a?(Array)
        object.map { |o| to_service_object(o) }
      else
        Hashie::Mash.new(object)
      end
    end

end
