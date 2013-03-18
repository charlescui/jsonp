require 'ansi/code'
require 'ansi/mixin'
require 'ostruct'
require "em-http-server"

$:.unshift('.')
$:.unshift(File.join(File.dirname(__FILE__)))

module Jsonp
	autoload :HttpResponse, 'jsonp/http_response'
	autoload :Server, 'jsonp/server'
	autoload :Handler, 'jsonp/handler'
	autoload :Version, 'jsonp/version'

	class << self
		def start!(host, port)
	      	EM.run{
				Signal.trap("INT")  { EventMachine.stop if EM.reactor_running?}
				Signal.trap("TERM") { EventMachine.stop if EM.reactor_running?}
				# 设置线程数，用以控制并发
				EventMachine.threadpool_size = 100
				@server_signature = EM.start_server host, port, Server
				STDERR.puts "[#{$$}] Start Worker http://#{host}:#{port}".magenta
	        }
	    end#end of start!

	    def stop
			if @server_signature
				EM.stop_server(@server_signature)
			end
	    end#end of stop
	end
end

# 文字颜色
class ::String
  include ANSI::Mixin
end