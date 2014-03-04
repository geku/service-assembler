# require 'rubygems'
# require 'bundler/setup'

require 'sinatra/base'
require 'json'
require 'haml'

class HtmlService < Sinatra::Base

  EMPLOYEES = [
      {name: 'Blake Gray', position: 'CEO' },
      {name: 'Marc Hamilton', position: 'CTO' },
      {name: 'Elias Hammond', position: 'Developer' },
      {name: 'Virginia Barker', position: 'Advisor' },
      {name: 'Jorge Rice', position: 'Group Head' },
      {name: 'Greg Fox', position: 'Vide President Development' },
      {name: 'Dustin Stewart', position: 'Office manager' },
      {name: 'Jeanne Baldwin', position: 'Purchasing manager' },
      {name: 'Meghan Carter', position: 'Receptionist' },
      {name: 'Wayne Stokes', position: 'Bookkeeper' },
      {name: 'Marguerite  Hall', position: 'Quality Engineer' },
      {name: 'Lillian Gardner', position: 'Community Manager' },
      {name: 'Ignacio Vaughn', position: 'SEO Specialist' },
      {name: 'Doyle Cox', position: 'Marketing Manager' },
      {name: 'Alexandra Boyd', position: 'Developer' },
      {name: 'Pedro Todd', position: 'Developer' },
      {name: 'Tommy Holt', position: 'Data Analyst' },
      {name: 'Judith  Norris', position: 'Brand Manager' },
      {name: 'Rufus Strickland', position: 'Developer' },
      {name: 'Madeline  Butler', position: 'Support Agent' },
      {name: 'Alan Schultz', position: 'Developer' },
      {name: 'Joanna Lindsey', position: 'Data Analyst' },
      {name: 'Evan Alexander', position: 'Operations Manager' },
      {name: 'Garrett Russell', position: 'Support Agent' },
      {name: 'Phillip Cummings', position: 'Support Agent' }
    ]

  set :server, :thin

  get '/employees' do
    @employees = get_employees(params[:position])
    haml :list
  end

  get '/employees.json' do
    employees = get_employees(params[:position])
    employees.to_json
  end


  private
    def get_employees(position = nil)
      if position.nil? || position == ''
        EMPLOYEES
      else
        EMPLOYEES.select {|e| e[:position] == position }
      end
    end
  
end
