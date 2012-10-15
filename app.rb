# app.rb

require 'sinatra'
require 'json'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'])

get '/' do
  @messages = Message.all
  erb :messages
end

get '/reset' do
  DataMapper.auto_migrate!
  "Messages reset!"
end

get '/addresses' do
  @addresses = Address.all
  erb :addresses
end


post '/' do
  
  message_contents = request.POST['message']
  message_from = request.POST['sender']
  @message_row = Message.new(:body => message_contents, :sender => message_from)
  @message_row.save 

  "Message posted!"

  sender_uri = request.POST['senderuri']
  @address_row = Address.new(:name => message_from, :uri => sender_uri)
  @address_row.save
end

class Message

	include DataMapper::Resource

	property :id, Serial # Auto-increment integer id
	property :body, Text # A longer text block
  property :sender, Text #This records who the message was sent from
	property :created_at, DateTime # Auto assigns data/time
  
end

class Address

  include DataMapper::Resource

  property :id, Serial # Auto-increment integer id
  property :name, Text # A longer text block
  property :uri, Text #This records who the message was sent from
  property :created_at, DateTime # Auto assigns data/time
  
end

DataMapper.finalize
