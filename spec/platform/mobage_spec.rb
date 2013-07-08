# -*- coding: utf-8 -*-
require 'spec_helper'

describe OpensocialWap::Platform do
  describe "mobage" do
    context "sandbox用に、mobage用の初期化が正しく行えること(セッションOFF)" do
      before do
        @config = Rails::Application::Configuration.new
        OpensocialWap::Platform.mobage(@config) do
          consumer_key '(consumer_key)'
          consumer_secret '(consumer_secret)'
          app_id '9999'
          sandbox true
          session false
        end
      end

      it do
        @config.opensocial_wap.oauth.helper_class.should == OpensocialWap::OAuth::Helpers::MobageHelper
        @config.opensocial_wap.oauth.helper_class.proxy_class.should == OpensocialWap::OAuth::RequestProxy::OAuthRackRequestProxy
        @config.opensocial_wap.oauth.helper_class.consumer_key.should == '(consumer_key)'
        @config.opensocial_wap.oauth.helper_class.consumer_secret.should == '(consumer_secret)'
        @config.opensocial_wap.oauth.helper_class.api_endpoint.should == 'http://sb.app.mbga.jp/api/restful/v1/'
        @config.opensocial_wap.oauth.helper_class.app_id.should == '9999'
        @config.opensocial_wap.session_id.should_not == :parameter
      end

      it "opensocial_wap.url は Proc で controller を渡すと request.mobile? の結果で切り替わる" do
        ctx = Object.new
        ctx.stub_chain(:request, :mobile?).and_return(true)
        retval = @config.opensocial_wap.url.call(ctx)
        retval.default.should == {:format => :query, :params => {:guid => "ON"}}

        ctx = Object.new
        ctx.stub_chain(:request, :mobile?).and_return(false)
        retval = @config.opensocial_wap.url.call(ctx)
        retval.default.should == {:format => :query, :params => {:guid => "ON"}}
      end
    end

    context "本番用に、mobage用の初期化が正しく行えること(セッションON)" do
      before do
        @config = Rails::Application::Configuration.new
        OpensocialWap::Platform.mobage(@config) do
          consumer_key '(consumer_key)'
          consumer_secret '(consumer_secret)'
          app_id '9999'
          sandbox false
          session true
        end
      end

      it do
        @config.opensocial_wap.oauth.helper_class.should == OpensocialWap::OAuth::Helpers::MobageHelper
        @config.opensocial_wap.oauth.helper_class.proxy_class.should == OpensocialWap::OAuth::RequestProxy::OAuthRackRequestProxy
        @config.opensocial_wap.oauth.helper_class.consumer_key.should == '(consumer_key)'
        @config.opensocial_wap.oauth.helper_class.consumer_secret.should == '(consumer_secret)'
        @config.opensocial_wap.oauth.helper_class.api_endpoint.should == 'http://app.mbga.jp/api/restful/v1/'
        @config.opensocial_wap.oauth.helper_class.app_id.should == '9999'
        @config.opensocial_wap.session_id.should == :parameter
      end

      it "opensocial_wap.url は Proc で controller を渡すと request.mobile? の結果で切り替わる" do
        ctx = Object.new
        ctx.stub_chain(:request, :mobile?).and_return(true)
        retval = @config.opensocial_wap.url.call(ctx)
        retval.default.should == {:format => :query, :params => {:guid => "ON"}}

        ctx = Object.new
        ctx.stub_chain(:request, :mobile?).and_return(false)
        retval = @config.opensocial_wap.url.call(ctx)
        retval.default.should == {:format => :query, :params => {:guid => "ON"}}
      end
    end
  end
end
