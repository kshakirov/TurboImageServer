require 'minitest'
require 'minitest/autorun'
require 'sinatra'
require "sinatra/activerecord"
require_relative '../../../lib/src/sync'

configuration = YAML::load(IO.read('database.yml'))
ActiveRecord::Base.establish_connection(configuration['development'])