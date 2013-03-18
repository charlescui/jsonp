require "em-http-request"

module Jsonp
	class Handler
		def self.handle(req, resp, timeout = 5)
			url = req.params["url"] && CGI.unescape(req.params["url"])
			type = req.params["jsonptype"]
			jsonp = req.params["jsonp"]

			if url and jsonp
				request = EM::HttpRequest.new(url).get( :timeout => timeout)
				request.callback {
					case type
					when /function/i
					  content = "#{jsonp}(#{request.response})"
					when /var/i
					  content = "#{jsonp} = #{request.response}"
					else
					  # 默认函数形式
					  content = "#{jsonp}(#{request.response})"
					end

					resp.plat_response('ok', 0)
					resp.content = content
					resp.send_response
				}
				request.errback {
					STDERR.puts(request.error)
					resp.plat_response('error', -1)
					resp.send_response
				}
			else
				resp.plat_response('Need params with jsonptype and jsonp', -2)
				resp.send_response
			end

		end
	end
end