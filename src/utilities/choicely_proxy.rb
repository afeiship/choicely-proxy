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
