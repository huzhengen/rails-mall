require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

ENV['ALIPAY_PID'] = 'YOUR-ALIPAY-PARTNER-ID'
ENV['ALIPAY_MD5_SECRET'] = 'YOUR-ALIPAY-MD5-SECRET'
ENV['ALIPAY_URL'] = 'https://mapi.alipay.com/gateway.do'
ENV['ALIPAY_RETURN_URL'] = 'http://localhost:3000/payments/pay_return'
ENV['ALIPAY_NOTIFY_URL'] = 'http://localhost:3000/payments/pay_notify'

module RailsMall
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.autoload_paths += %W[#{Rails.root}/lib]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
