require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present? || true
  config.assets.compile = false
  config.active_storage.service = :local
  config.log_level = :debug
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  # --- メール設定（Resend版） ---
  config.action_mailer.default_url_options = { host: 'manimanisanpo.onrender.com', protocol: 'https' }
  
  # 送信方法を Gmail から SMTP (Resend) に変更
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  
  # エラーでサーバーが止まらないようにしつつ、原因はログに出す
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.smtp_settings = {
    address:              'smtp.resend.com',
    port:                 587,
    user_name:            'resend', # ここは「resend」という文字列固定でOK
    password:             ENV['RESEND_API_KEY'], # Renderに設定した APIキー
    authentication:       'plain',
    enable_starttls_auto: true
  }
end
