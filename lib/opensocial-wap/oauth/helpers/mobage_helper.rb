# -*- coding: utf-8 -*-
module OpensocialWap::OAuth::Helpers

  # mobage 用 oauthヘルパー.
  # バッチタイプ(mobageではTrusted モデル)のリクエスト時には、xoauth_requestor_id
  # としてapp_id を渡すところが、BasicHelper と異なる.
  class MobageHelper < BasicHelper

    def authorization_header(api_request, options = nil)
      opts = { :consumer => consumer }
      opts[:token] = access_token if access_token
      if @request
        opts[:xoauth_requestor_id] = @request.params['opensocial_viewer_id'] || @request.params['opensocial_owner_id']
      else
        opts[:xoauth_requestor_id] = self.class.app_id # <= 変更点.
      end
      oauth_client_helper = ::OAuth::Client::Helper.new(api_request, opts.merge(options))
      oauth_client_helper.header
    end

    #
    # FP, SPでendpointを切り替える
    #
    def api_endpoint
      if @request.respond_to?(:mobile?) && @request.mobile?
        self.class.api_endpoint
      else
        self.class.sp_api_endpoint
      end
    end

    private

    #
    # スマートフォン設定項目の追加
    #
    def self.sp_api_endpoint(arg = nil)
      if arg
        @sp_api_endpoint = arg
      end
      @sp_api_endpoint if @sp_api_endpoint
    end

  end
end
