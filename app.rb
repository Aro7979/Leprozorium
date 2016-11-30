require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra\">Original</a> pattern has been modifiled for Rubi School"	
end
get '/new' do
   erb :new
end
