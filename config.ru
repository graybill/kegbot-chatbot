require 'bundler'
Bundler.require
require 'sinatra'
require './web.rb'
run Web.new