# Render-specific configuration
bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 3000)}"  # MUST use this exact format
workers ENV.fetch("WEB_CONCURRENCY", 1) if ENV.fetch("RACK_ENV", "development") == "production"

# Standard configuration
threads_count = ENV.fetch("RAILS_MAX_THREADS", 3)
threads threads_count, threads_count
plugin :tmp_restart
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"] && ENV["RACK_ENV"] == "production"
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]