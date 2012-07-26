# -*- coding: utf-8 -*-
require 'spec_helper'

describe OpensocialWap::Platform do
  describe "mixi2" do
    context "mixi2用の初期化が正しく行えること" do
      before do
        @config = Rails::Application::Configuration.new
        OpensocialWap::Platform.mixi2(@config) do
          consumer_key '(consumer_key)'
          consumer_secret '(consumer_secret)'
          session false
        end
      end

      it do
        @config.opensocial_wap.oauth.helper_class.should                 == OpensocialWap::OAuth::Helpers::BasicHelper
        @config.opensocial_wap.oauth.helper_class.proxy_class.should     == OpensocialWap::OAuth::RequestProxy::OAuthRackRequestProxyForMixi
        @config.opensocial_wap.oauth.helper_class.consumer_key.should    == '(consumer_key)'
        @config.opensocial_wap.oauth.helper_class.consumer_secret.should == '(consumer_secret)'
        @config.opensocial_wap.oauth.helper_class.api_endpoint.should    == 'http://api.mixi-platform.com/os/0.8/'
      end

      it "opensocial_wap.url は Proc で controller を渡すと request.mobile? の結果で切り替わる" do
        ctx = Object.new
        ctx.stub_chain(:request, :mobile?).and_return(true)
        retval = @config.opensocial_wap.url.call(ctx)
        retval.default.should == {:format => :query, :params => {:guid => "ON"}}

        ctx = Object.new
        ctx.stub_chain(:request, :mobile?).and_return(false)
        retval = @config.opensocial_wap.url.call(ctx)
        retval.default.should == {:format => :local}
      end
    end
  end
end
