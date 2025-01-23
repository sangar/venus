#require "httparty"
require "uri"
require "net/http"
require "json"
require "dotenv/load"

public_dns_name = "this.is.the.content."

#request = Net::HTTP::Put.new(uri.host, uri.port)
#request.use_ssl = true
#http.verify_mode = OpenSSL::SSL::VERIFY_NONE


headers = {
  "Content-type": "application/json",
  "X-Auth-Email": ENV["CLOUDFLARE_AUTH_EMAIL"],
  "X-Auth-Key": ENV["CLOUDFLARE_AUTH_KEY"]
}

body = { "type": "CNAME", "name": "minecraft", "content": "#{public_dns_name}" }

#HTTParty.patch(
#  "https://api.cloudflare.com/client/v4/zones/#{ENV["CLOUDFLARE_ZONE_ID"]}/dns_records/#{ENV["CLOUDFLARE_RECORD_ID"]}",
#  body: body.to_json,
#  headers: headers,
#  debug_output: $stdout
#)

uri=URI("https://api.cloudflare.com/client/v4/zones/#{ENV["CLOUDFLARE_ZONE_ID"]}/dns_records/#{ENV["CLOUDFLARE_RECORD_ID"]}")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

headers = {
  "X-Auth-Email" => ENV["CLOUDFLARE_AUTH_EMAIL"],
  "X-Auth-Key" => ENV["CLOUDFLARE_AUTH_KEY"],
  "Content-Type" => "application/json"
}
params = { "type": "CNAME", "name": ENV["CLOUDFLARE_CNAME"], "content": "#{public_dns_name}"}
resp = http.put(uri.path, params.to_json, headers)

if resp.code.eql?("200")
  puts "code is OK"
else
  puts "resp.code: #{resp.code}"
  puts "resp.code: #{resp.code.class.name}"
end

