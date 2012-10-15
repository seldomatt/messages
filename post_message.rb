# post_message.rb

require "net/http"

address_book = {}

puts ""
print "Who do you want to message? "
name = gets.chomp

print "Your message: "
message = gets.chomp

print "From: "
sender = gets.chomp

puts ""
print "Sending message..."

uri = URI("http://#{name}-messages.herokuapp.com")
sender_uri = URI("http://#{sender}-messages.herokuapp.com")

# TODO: Post the message to the server
res = Net::HTTP.post_form(uri, "message" => message, "sender" => sender)
res1 = Net::HTTP.post_form(uri, "sender" => sender, "senderuri" => sender_uri)

puts "done!"
puts "Result: #{res.body} #{res1.body}"

puts ""



