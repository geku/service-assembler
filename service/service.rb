# require 'rubygems'
# require 'bundler/setup'

require 'awesome_print'
require 'sinatra/base'
require 'haml'

class HtmlService < Sinatra::Base
  
  set :server, :thin
  
  get '/employees' do
    position = params[:position]

    employees = [
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
      {name: 'Tommy Holt', position: 'Dara Analyst' },
      {name: 'Judith  Norris', position: 'Brand Manager' },
      {name: 'Rufus Strickland', position: 'Developer' },
      {name: 'Madeline  Butler', position: 'Support Agent' },
      {name: 'Alan Schultz', position: 'Developer' },
      {name: 'Joanna Lindsey', position: 'Data Analyst' },
      {name: 'Evan Alexander', position: 'Operations Manager' },
      {name: 'Garrett Russell', position: 'Support Agent' },
      {name: 'Phillip Cummings', position: 'Support Agent' }
    ]


    @employees = if !position.nil?
      employees.select {|e| e[:position] == position }
    else
      employees
    end

    haml :list
  end
  
end
