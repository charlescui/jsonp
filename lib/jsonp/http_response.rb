module Jsonp
	class HttpResponse < EM::DelegatedHttpResponse
		attr_accessor :start_at, :end_at, :request

		def initialize(*args)
			@start_at = Time.now
			super
		end

		def send_headers(*args)
			@end_at = Time.now
			headers['X-Runtime'] = @end_at.to_f - @start_at.to_f
			super
		end

		def plat_response(msg, code = 0)
	        headers['X-Plat-Status-Message'] = msg
	        headers['X-Plat-Status-Code'] = code
		end

		def fixup_headers
			if @content
				# 原生代码使用的是to_s.length，如果是汉字的话则不正确
				@headers["Content-length"] = @content.to_s.bytesize
			elsif @chunks
				@headers["Transfer-encoding"] = "chunked"
				# Might be nice to ENSURE there is no content-length header,
				# but how to detect all the possible permutations of upper/lower case?
			elsif @multiparts
				@multipart_boundary = self.class.concoct_multipart_boundary
				@headers["Content-type"] = "multipart/x-mixed-replace; boundary=\"#{@multipart_boundary}\""
			else
				@headers["Content-length"] = 0
			end
		end
	end
end