# -*- coding: utf-8 -*-
module OpensocialWap
  module Platform
    # Singleton Pattern
    extend self

    def mixi2(config, &block)
      @config = config
      # @access_from_pc = false
      instance_eval(&block)

      consumer_key    = @consumer_key
      consumer_secret = @consumer_secret
      app_id          = @app_id
      # container_host  = @access_from_pc ? "ma.test.mixi.net" : "ma.mixi.net"

      OpensocialWap::OAuth::Helpers::BasicHelper.configure do
        proxy_class     OpensocialWap::OAuth::RequestProxy::OAuthRackRequestProxyForMixi
        consumer_key    consumer_key
        consumer_secret consumer_secret
        api_endpoint    "http://api.mixi-platform.com/os/0.8/"
        app_id          app_id
      end

      @config.opensocial_wap.oauth = OpensocialWap::Config::OAuth.configure do
        helper_class OpensocialWap::OAuth::Helpers::BasicHelper
      end

      if true
        # 完全に動的(container_hostは使わない)
        @config.opensocial_wap.url = proc{|context|OpensocialWap::Config::DynamicUrl.new(context)}
      else
        # 静的の設定を動的に切り替え
        @config.opensocial_wap.url = proc{|context|
          if context.request.mobile?
            # fp
            OpensocialWap::Config::Url.configure do
              container_host container_host
              default     :format => :query, :params => { :guid => "ON" }
              redirect    :format => :full,  :params => { :guid => "ON" }
              public_path :format => :local
            end
          else
            # sp
            OpensocialWap::Config::Url.configure do
              container_host container_host
              default     :format => :local
              redirect    :format => :local
              public_path :format => :local
            end
          end
        }
      end

      @config.opensocial_wap.session_id = @session ? :parameter : :cookie
    end

    # def access_from_pc(access_from_pc = true)
    #   @access_from_pc = access_from_pc
    # end
  end
end
