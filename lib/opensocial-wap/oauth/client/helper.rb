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
            # mixiの課金用に用意したbody_hashに置き換える
            # http://developer.mixi.co.jp/appli/spec/mob/payment_api/
            'oauth_body_hash' => options[:oauth_body_hash],  # Digest::SHA1.base64digest(str) の結果
          }.reject { |k,v| v.blank? }
        end
      end
    end
  end
end

class OAuth::Client::Helper
  include ::OpensocialWap::OAuth::Client::Helper
end
