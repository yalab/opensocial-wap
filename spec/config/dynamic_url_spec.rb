# -*- coding: utf-8 -*-
require 'spec_helper'

describe OpensocialWap::Config::DynamicUrl do
  it "USER_AGENTを変更してfp用のホストにアクセスする場合" do
    ctx = Object.new
    ctx.stub_chain(:request, :mobile?).and_return(true)
    ctx.stub_chain(:request, :user_agent).and_return("DoCoMo/2.0 N901iS(c100;TB;W24H12) TEST")
    config = OpensocialWap::Config::DynamicUrl.new(ctx)
    config.container_host.should == "ma.test.mixi.net"
    config.default.should == {:format => :query, :params => {:guid => "ON"}}
    config.redirect.should == {:format => :full, :params => {:guid => "ON"}, :container_host => "ma.test.mixi.net"}
    config.public_path.should == {:format => :local}
  end

  it "spの場合はma.test.mixi.netのまま" do
    ctx = Object.new
    ctx.stub_chain(:request, :mobile?).and_return(false)
    ctx.stub_chain(:request, :user_agent).and_return("Mozilla/5.0 (iPhone; U; CPU iPhone OS 2_0 like Mac OS X; ja-jp) AppleWebKit/525.18.1 (KHTML, like Gecko) Version/3.1.1 Mobile/5A345 Safari/525.20")
    config = OpensocialWap::Config::DynamicUrl.new(ctx)
    config.container_host.should == "ma.mixi.net"
  end

  it "reqest自体を渡せる(というか渡した方がいい)" do
    request = Object.new
    request.stub(:mobile?).and_return(true)
    request.stub(:user_agent).and_return("")
    config = OpensocialWap::Config::DynamicUrl.new(request)
    config.container_host.should be_present
  end
end
