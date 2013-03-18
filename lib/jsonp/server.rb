module Jsonp
	class Server < EM::HttpServer::Server
		def process_http_request
			@request = get_request
        	@response = HttpResponse.new(self)

        	begin
        		case @request.request_uri
	        	when '/'
	        		Handler.handle(@request, @response)
	        	end
        	rescue Exception => e
        		resp.plat_response('not support service', -3)
				resp.send_response
        	end
		end

		private

		def get_request
	        request = OpenStruct.new(   
	            :request_method => @http_request_method,
	            :request_uri => @http_request_uri,
	            :query_string => @http_query_string,
	            :protocol => @http_protocol,
	            :content => @http_content,
	            :headers => @http,
	            :params => query_str_to_hash(@http_query_string)
	        )
	        if request.content
	            request.params.merge!(query_str_to_hash(@http_content))
	        end
	        request
	    end

	    def query_str_to_hash(http_query_string)
	        h = {}
	        http_query_string && http_query_string.split("&").each{|pair| key, value = pair.split('='); h[key] = value; h[key.to_sym] = value}
	        h
	    end
	end
end