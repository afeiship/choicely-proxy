#!/usr/bin/env ruby

# Instead of loading all of Rails, load the
# particular Rails dependencies we need

require_relative "./initialize"
include Nx

DEFAULT_OPTIONS = { should_destroy: false, thread: 60 }

class ChoicelyProxy
  def initialize
    @real_ip = RealIp.get
  end

  def fetch(proxy)
    puts "current proxy is: #{proxy}"
    proxy_url = "http://#{proxy[:ip]}:#{proxy[:port]}"
    begin
      current_ip = RealIp.get(proxy: proxy_url, timeout: 5)
      if current_ip.nil? || current_ip == @real_ip
        nil
      else
        proxy
      end
    rescue Exception => e
      puts e.class
      if e.class == Interrupt || e.class == SignalException
        puts "Break by manural~"
      end
    end
  end
end

class App
  def initialize(options)
    @options = {}.merge(DEFAULT_OPTIONS, options)
    load_proxies
    @cp_app = ChoicelyProxy.new
    @rows = []
  end

  def load_proxies
    @proxies = SpysProxy.fetch + GatherProxy.fetch + UsProxy.fetch + XiciProxy.fetch
  end

  def start
    puts "proxies size: #{@proxies.size}"
    size = @proxies.size / @options[:thread]
    threads = @proxies.each_slice(size).map do |items|
      Thread.new do
        items.each do |proxy|
          res = @cp_app.fetch(proxy)
          unless res.nil?
            @rows << { ip: res[:ip], port: res[:port], url: "http://#{res[:ip]}:#{res[:port]}" }
          end
        end
      end
    end

    threads.each(&:join)

    if @rows.empty?
      load_proxies
      start
    else
      if @options[:should_destroy]
        proxies = Proxy.all
        proxies.destroy_all
      end
      Proxy.create(@rows)
    end
  end
end

app = App.new({ should_destroy: true })
app.start

# http_proxy=http://120.234.63.196:3128 curl -i icanhazip.com
# http_proxy=http://39.137.95.71:8080 curl -i icanhazip.com
# http_proxy=http://39.102.32.5:8080 curl -i icanhazip.com
# http_proxy=http://106.39.250.4:3128 curl -i icanhazip.com

# http_proxy=http://120.24.88.98:3128 curl -i icanhazip.com

# re_ip = /\b\d+\.\d+\.\d+\.\d+\b/

# real_ip = open(
#   "http://icanhazip.com/",
#   read_timeout: 5,
#   open_timeout: 5,
#   proxy: "http://111.230.138.177:8080",
# ).read

# p real_ip

# p Nx::RealIp.get(proxy: "http://111.230.138.177:8080")
