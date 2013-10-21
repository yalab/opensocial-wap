# -*- coding: utf-8 -*-
AppRoot::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = true

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  # OpenSocial WAP Extention
  
  config.opensocial_wap.oauth = OpensocialWap::Config::OAuth.configure do
    OpensocialWap::OAuth::Helpers::BasicHelper.configure do
      consumer_key    'abcdef'
      consumer_secret 'abcdefg12345'
      api_endpoint    'http://api.example.com/'
    end
    helper_class OpensocialWap::OAuth::Helpers::BasicHelper
  end

  config.opensocial_wap.url = OpensocialWap::Config::Url.configure do
    container_host 'container.example.com'
    default     :format => :full, :params => { :guid => 'ON' }
    redirect    :format => :query, :params => { :guid => 'ON' }
    public_path :format => :plain
  end

  config.opensocial_wap.session_id = :parameter

  # 以下、テスト用の設定.
  require File.expand_path("../../lib/opensocial_wap_sid_enabler", File.dirname(__FILE__))
  if Rails::VERSION::MAJOR < 4
    config.middleware.insert_before ActiveRecord::SessionStore, OpensocialWapSidEnabler
  else
    require 'activerecord/session_store'
  end
end

