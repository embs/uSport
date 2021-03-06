# encoding: utf-8
require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  # Bundler.require(*Rails.groups(:assets => %w(development test)))
  Bundler.require(*Rails.groups(:assets))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module USport
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
    config.active_record.observers = :user_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.2'

    # Configura o timezone
    config.time_zone = 'Brasilia'
    config.active_record.default_timezone = :local

    # Configura o locale
    config.i18n.default_locale = "pt-BR"
    config.i18n.locale = "pt-BR" # Configuração de fix para o Heroku

    # Configuração de fix para o Heroku
    config.assets.initialize_on_precompile = false

    # Faz com que sejam geradas factories em vez de fixtures do Rails
    config.generators do |g|
      g.fixture_replacement :factory_girl
      g.stylesheets false
      g.javascripts false
      g.helper false
    end

    # Carrega arquivos de locales dentro de subdiretórios
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # Configurações de e-mail do ActionMailer
    ActionMailer::Base.smtp_settings = {
      address: "smtp.gmail.com",
      port: 587,
      authentication: :plain,
      domain: 'quinceminds@gmail.com',
      user_name: 'quinceminds@gmail.com',
      password: 'xadrez2012',
    }

    # Algumas configurações (a mais) do action_mailer
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.default charset: 'utf-8'

    config.paperclip = {
      default_url: "avatars/missing.gif"
    }

    config.paperclip_user = config.paperclip.merge({
      styles: {
        thumb_16: '16x16#',
        thumb_24: '24x24#',
        thumb_32: '32x32#',
        thumb_90: '90x90#',
        thumb_110: '110x110#'
      }
    })

    config.paperclip_channel = config.paperclip.merge({
      styles: {
        thumb_32: '32x32#',
        thumb_90: '90x90#',
        thumb_140: '140x140#'
      }
    })

    config.paperclip_team = config.paperclip.merge({
      styles: {
        thumb_24: '24x24#',
        thumb_32: '32x32#',
        thumb_90: '90x90#',
        thumb_110: '110x110#'
      }
    })
  end
end
