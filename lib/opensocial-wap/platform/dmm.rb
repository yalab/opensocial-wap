# -*- coding: utf-8 -*-
module OpensocialWap
  module Platform
    # Singleton Pattern
    extend self

    def dmm(config, &block)
      configure(config)
      @sandbox = false
      instance_eval(&block)

      consumer_key    = @consumer_key
      consumer_secret = @consumer_secret
      app_id          = @app_id
      api_endpoint    = @sandbox ? 'http://sbx-osapi.dmm.com/social/rest/' : 'https://osapi.dmm.com/social/rest/'
      sp_api_endpoint = @sandbox ? 'http://sbx-osapi.dmm.com/social_sp/rest/' : 'https://osapi.dmm.com/social_sp/rest/'

      OpensocialWap::OAuth::Helpers::GreeHelper.configure do
        proxy_class     OpensocialWap::OAuth::RequestProxy::OAuthRackRequestProxyForGree  # GREEと同仕様
        consumer_key    consumer_key
        consumer_secret consumer_secret
        api_endpoint    api_endpoint
        sp_api_endpoint sp_api_endpoint
        app_id          app_id
      end

      @config.opensocial_wap.oauth = OpensocialWap::Config::OAuth.configure do
        helper_class OpensocialWap::OAuth::Helpers::GreeHelper  # GREEと同仕様
      end

      @config.opensocial_wap.url = proc{|context| OpensocialWap::Config::DmmDynamicUrl.new(context, @sandbox)}

      @config.opensocial_wap.session_id = @session ? :parameter : :cookie
    end
  end
end
