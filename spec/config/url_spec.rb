# -*- coding: utf-8 -*-
require 'spec_helper'

describe OpensocialWap::Config::Url do
  it do
    config = ::OpensocialWap::Config::Url.configure do
      container_host 'c.example.com'
      default      :format => :full, :container_host => 'c.example.com', :params => { :guid => 'ON' }
      redirect     :format => :query, :params => { :guid => 'ON' }
      public_path  :format => :plain
    end

    config.container_host.should == 'c.example.com'
    config.default.should == {:format => :full, :container_host => 'c.example.com', :params => { :guid => 'ON' }}
    config.redirect.should == { :format => :query, :params => { :guid => 'ON' }}
    config.public_path.should == { :format => :plain }
  end
end
