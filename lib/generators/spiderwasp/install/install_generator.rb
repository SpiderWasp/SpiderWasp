class Spiderwasp::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  def init_spiderwasp_config
    gem 'rack-attack'
    application %q(config.middleware.use Rack::Attack)
    initializer "spiderwasp.rb" do
      %q(
uri = URI.parse(ENV["SPIDERWASP_REDIS_URL"] || "redis://localhost:6379/" )
$redis_conn = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

Rack::Attack.blocklisted_response = lambda do |env|
  # Using 503 because it may make attacker think that they have successfully
  # DOSed the site. Rack::Attack returns 403 for blocklists by default
  [ 503, {}, ['Blocked']]
end

Rack::Attack.blocklist('block misbehaving clients via Spiderwasp') do |req|
  is_in_blacklist = ($redis_conn.get("spiderwasp:drop:#{req.ip}") == "true")
  Rails.logger.info { "[spiderwasp] #{req.ip} - #{req.path} - #{(is_in_blacklist ? 'deny' : 'allow')} - #{req.user_agent}"}
  is_in_blacklist
end
)
    end
  end
end
