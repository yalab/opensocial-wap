# -*- coding: utf-8 -*-
require 'spec_helper'

describe OpensocialWap::Config::GreeDynamicUrl do
  context "USER_AGENTを変更してfp用のホストにアクセスする場合" do
    before do
      @ctx = Object.new
      @ctx.stub_chain(:request, :mobile?).and_return(true)
      @ctx.stub_chain(:request, :user_agent).and_return("DoCoMo/2.0 N901iS(c100;TB;W24H12)")
    end

    it "sandbox enable" do
      config = OpensocialWap::Config::GreeDynamicUrl.new(@ctx, true)
      config.container_host.should == 'mgadget-sb.gree.jp'
      config.default.should == {:format => :query, :params => {:guid => "ON"}}
      config.redirect.should == {:format => :local}
      config.public_path.should == {:format => :local}
    end
    it "sandbox disable" do
      config = OpensocialWap::Config::GreeDynamicUrl.new(@ctx, false)
      config.container_host.should == 'mgadget.gree.jp'
      config.default.should == {:format => :query, :params => {:guid => "ON"}}
      config.redirect.should == {:format => :local}
      config.public_path.should == {:format => :local}
    end
  end

  describe "spの場合" do
    before do
      @ctx = Object.new
      @ctx.stub_chain(:request, :mobile?).and_return(false)
      @ctx.stub_chain(:request, :user_agent).and_return("Mozilla/5.0 (iPhone; U; CPU iPhone OS 2_0 like Mac OS X; ja-jp) AppleWebKit/525.18.1 (KHTML, like Gecko) Version/3.1.1 Mobile/5A345 Safari/525.20")
    end

    it "sandbox enable" do
      config = OpensocialWap::Config::GreeDynamicUrl.new(@ctx, true)
      config.container_host.should == 'pf-sb.gree.jp'
    end
    it "sandbox disable" do
      config = OpensocialWap::Config::GreeDynamicUrl.new(@ctx, false)
      config.container_host.should == 'pf.gree.jp'
    end
  end

  it "reqest自体を渡せる(というか渡した方がいい)" do
    request = Object.new
    request.stub(:mobile?).and_return(true)
    request.stub(:user_agent).and_return("")
    config = OpensocialWap::Config::GreeDynamicUrl.new(request, false)
    config.container_host.should be_present
  end
end
