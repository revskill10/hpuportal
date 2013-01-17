require 'rubygems'
require 'sequel'
require 'sinatra'
DB = Sequel.connect('postgres://casserver:123456@10.1.0.238:5432/casserver')


items = DB[:credentials] # Create a dataset

get '/users' do
# Populate the table
#items.where('username = ?', 'dungth@hpu.edu.vn').update(:msv => '123');
#items.insert(:username => 'ruby', :password => '456', :msv => 'david')
# Print out the number of records

	return {:items => items.to_a}.to_hash
end

# Print out the average price
post '/users' do
	username = params[:username].strip
	password = params[:password].strip
	msv = params[:msv].strip
	sv = {:username => username, :password => password, :msv => msv}
	items.insert(sv)
	return {:sv => sv}.to_hash
end

post '/users/:id' do
	username = params[:id].strip
	newpass = params[:password].strip
	items.where('username = ?', username).update(:password => newpass);
	sv = items.where('username = ?', username).to_a[0]
	return {:sv => sv}.to_hash
end

get '/users/:id/' do
	username = params[:id].strip
	sv = items.where('username = ?', username).to_a[0]
	return {:sv => sv}.to_hash
end