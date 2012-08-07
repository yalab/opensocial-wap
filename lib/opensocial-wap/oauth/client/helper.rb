# -*- coding: utf-8 -*-
require 'uri'
require 'net/http'

# OAuth::Client::Helper を変更して、OAuth に使用するパラメターに、
# xoauth_requestor_id を追加.

module OpensocialWap::OAuth::Client
  module Helper

    def self.included(base)
      base.class_eval do

        def oauth_parameters
          {
            'oauth_body_hash'        => options[:body_hash],
            'oauth_callback'         => options[:oauth_callback],
            'oauth_consumer_key'     => options[:consumer].key,
            'oauth_token'            => options[:token] ? options[:token].token : '',
            'oauth_signature_method' => options[:signature_method],
            'oauth_timestamp'        => timestamp,
            'oauth_nonce'            => nonce,
            'oauth_verifier'         => options[:oauth_verifier],
            'oauth_version'          => (options[:oauth_version] || '1.0'),
            'oauth_session_handle'   => options[:oauth_session_handle],
            'xoauth_requestor_id'    => options[:xoauth_requestor_id], # 追加

            # mixi課金対応
            # http://developer.mixi.co.jp/appli/spec/mob/payment_api/
            'opensocial_app_id'   => options[:opensocial_app_id],   # "1"
            'opensocial_owner_id' => options[:opensocial_owner_id], # "1"
            'point_code'          => options[:point_code],          # "7HBcfrCFnpHf7nCew3sy"
            'status'              => options[:status],              # "10"
            'updated'             => options[:updated],             # "2009-09-03T06:34:29Z"
          }.reject { |k,v| v.blank? }
        end
      end
    end
  end
end

class OAuth::Client::Helper
  include ::OpensocialWap::OAuth::Client::Helper
end
