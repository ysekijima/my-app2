require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  # 既存のログフォーマッターを使用
  config.log_formatter = ::Logger::Formatter.new

  # ログに controller と action を追加
  class CustomLogFormatter < Logger::Formatter
    def call(severity, timestamp, progname, msg)
      request_info = Thread.current[:log_request_info] || {}
      controller_action = request_info[:controller] && request_info[:action] ? "[#{request_info[:controller]}##{request_info[:action]}]" : ""
      "#{timestamp.iso8601} [#{severity}] #{controller_action} #{msg}\n"
    end
  end

  config.logger = ActiveSupport::Logger.new(STDOUT)
  config.logger.formatter = CustomLogFormatter.new

  # リクエストごとに controller, action を記録
  ActiveSupport::Notifications.subscribe("start_processing.action_controller") do |*args|
    event = ActiveSupport::Notifications::Event.new(*args)
    payload = event.payload
    Thread.current[:log_request_info] = {
      controller: payload[:controller],
      action: payload[:action]
    }
  end

  # `process_action.action_controller` では情報をクリアしない
  # リクエスト終了後にクリアする
  config.middleware.insert_after ActionDispatch::Executor, Middleware::ClearLogRequestInfo if defined?(Middleware::ClearLogRequestInfo)
end

# ミドルウェアを定義（リクエスト終了後にクリア）
module Middleware
  class ClearLogRequestInfo
    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    ensure
      Thread.current[:log_request_info] = nil
    end
  end
end
