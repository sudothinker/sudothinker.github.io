require 'toto'
class XOriginEnabler
  ORIGIN_HEADER = "Access-Control-Allow-Origin"
 
  def initialize(app, accepted_domain="*")
    @app = app
    @accepted_domain = accepted_domain
  end
 
  def call(env)
    status, header, body = @app.call(env)
    header[ORIGIN_HEADER] = @accepted_domain
    [status, header, body]
  end
end

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/img', '/html', '/favicon.ico'], :root => 'public'
use Rack::ShowExceptions
use Rack::CommonLogger
use XOriginEnabler, "http://tri.sudothinker.com"

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

