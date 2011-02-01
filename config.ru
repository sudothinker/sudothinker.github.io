require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::ShowExceptions
use Rack::CommonLogger

# Run application
toto = Toto::Server.new do  
  # Add your settings here
  # set [:setting], [value]
  #
  set :author, "Sudothinker"
  set :title, "Sudothinker"
  set :url, "http://sudothinker.com"
  set :disqus, "sudothinker"
  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
  set :markdown, :smart
end

run toto

