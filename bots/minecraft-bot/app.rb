#
# https://docs.aws.amazon.com/code-samples/latest/catalog/ruby-ec2-ec2-ruby-example-reboot-instance-i-123abc.rb.html

require "discordrb"
require "aws-sdk-ec2"
require "uri"
require "net/http"
require "json"
require "dotenv/load"

bot = Discordrb::Bot.new(token: ENV["DISCORD_BOT_TOKEN"])

puts "This bot's invite URL is #{bot.invite_url}."
puts 'Click on it to invite it to your server.'

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.mention do |event|
  if event.content.include?("stop")
    stop_instance(event)
  elsif event.content.include?("start")
    start_instance(event)
  elsif event.content.include?("state")
    get_state(event)
  elsif event.content.include?("status")
    get_state(event)
  elsif event.content.include?("reboot")
    reboot_instance(event)
  elsif event.content.include?("info")
    event.respond("Command are `start`, `stop`, `state`, `status`, `reboot` and `info`")
  else
    event.respond("⁇⁇⁇")
  end
end

def start_instance(event)
  begin
    ec2 = Aws::EC2::Client.new(region: ENV["AWS_REGION"])

    event.respond("instance starting")
    ec2.start_instances(instance_ids: [ENV["AWS_EC2_INSTANCE_ID"]])
    ec2.wait_until(:instance_running, instance_ids:[ENV["AWS_EC2_INSTANCE_ID"]])
    puts "instance running"
    event.respond("instance is running")
    get_state(event)
  rescue Aws::Waiters::Errors::WaiterFailed => error
    puts "failed waiting for instance running: #{error.message}"
    event.respond("instance not started")
  end
end

def stop_instance(event)
  begin
    ec2 = Aws::EC2::Client.new(region: ENV["AWS_REGION"])

    event.respond("stopping instance")
    ec2.stop_instances(instance_ids: [ENV["AWS_EC2_INSTANCE_ID"]])
    ec2.wait_until(:instance_stopped, instance_ids:[ENV["AWS_EC2_INSTANCE_ID"]])
    puts "instance stopped"
    event.respond("instance is stopped")
  rescue Aws::Waiters::Errors::WaiterFailed => error
    puts "failed waiting for instance to stop: #{error.message}"
    event.respond("instance not stopped")
  end
end

def get_state(event)
  ec2 = Aws::EC2::Client.new(region: ENV["AWS_REGION"])

  resp = ec2.describe_instances(instance_ids: [ENV["AWS_EC2_INSTANCE_ID"]])
  if resp.count.zero?
    event.respond("no instance found")
  else
    instance = resp.reservations[0].instances[0]
    if instance.public_ip_address
      event.respond("state #{instance.state.name}, ip: #{instance.public_ip_address}, dns: #{instance.public_dns_name}")
      update_dns(event, instance)
    else
      event.respond("state #{instance.state.name}")
    end
  end
end

def reboot_instance(event)
  ec2 = Aws::EC2::Client.new(region: ENV["AWS_REGION"])

  resp = ec2.describe_instances(instance_ids: [ENV["AWS_EC2_INSTANCE_ID"]])
  if resp.count.zero?
    event.respond("no instance found")
  else
    ec2.reboot_instances(instance_ids: [ENV["AWS_EC2_INSTANCE_ID"]])
    event.respond("rebooting instance")
  end
end

def update_dns(event, instance)
  uri=URI("https://api.cloudflare.com/client/v4/zones/#{ENV["CLOUDFLARE_ZONE_ID"]}/dns_records/#{ENV["CLOUDFLARE_RECORD_ID"]}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  headers = {
    "X-Auth-Email" => ENV["CLOUDFLARE_AUTH_EMAIL"],
    "X-Auth-Key" => ENV["CLOUDFLARE_AUTH_KEY"],
    "Content-Type" => "application/json"
  }
  params = { "type": "CNAME", "name": ENV["CLOUDFLARE_CNAME"], "content": "#{instance.public_dns_name}"}
  resp = http.put(uri.path, params.to_json, headers)
  unless resp.code.eql?("200")
    event.respond("unable to update DNS")
  end
end

bot.run
