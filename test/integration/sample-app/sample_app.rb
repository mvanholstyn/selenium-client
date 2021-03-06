#!/usr/bin/env ruby

$:.unshift File.expand_path(File.dirname(__FILE__) + "/../../../vendor/sinatra-0.9.0.4/lib")
$:.unshift File.expand_path(File.dirname(__FILE__) + "/../../../vendor/rack-0.9.1/lib")

require 'sinatra'

get "/" do
  "Selenium Ruby Client Sample Application"
end

post "/compute" do
  sleep 5 # Sleep  a little while to test wait_for_ajax semantics
  eval(params[:'calculator-expression']).to_s
end

get "/shutdown" do
  Process.kill('KILL', Process.pid)
end
