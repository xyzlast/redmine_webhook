module Jandi_api_wrapper
  def send_to_jandi(_endpoint,m)
      #begin
      project=m["payload"]["issue"]["project"]["name"]
      action=m["payload"]["action"]
      subject=m["payload"]["issue"]["subject"]
      desc=m["payload"]["issue"]["description"]
      author=(m["payload"]["issue"]["author"].nil?) ? "": m["payload"]["issue"]["author"]["login"]
      assignee=(m["payload"]["issue"]["assignee"].nil?) ? "not assign": m["payload"]["issue"]["assignee"]["login"]
      status=m["payload"]["issue"]["status"]["name"]
      url=m["payload"]["url"]
        @msgbody = {
          body: "[#{project}:#{status}:#{assignee}] #{subject} #{action}", #Body text (Required)
          connectColor: '#FAC11B',
          connectInfo: [
            {
              # title: "#{subject}" ,
              description: "#{desc}",
              imageUrl: "#{url}"
            },
          ]
        }.to_json

        uri = URI(_endpoint)
        http = Net::HTTP.new(uri.host, 443)
        request = Net::HTTP::Post.new(uri.request_uri,initheader = {'Content-Type' =>'application/json','Accept' =>'application/vnd.tosslab.jandi-v2+json'})
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request.body = "#{@msgbody}"
        res = http.request(request)
        puts res.body
      #rescue Exception => e
      #end
   end
  end
