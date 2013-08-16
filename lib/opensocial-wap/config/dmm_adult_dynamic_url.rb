# -*- coding: utf-8 -*-

# Url 関係設定.
module OpensocialWap
  module Config
    #
    # 実行時にURLを決定したいときの設定 Dmm Adult
    #
    class DmmAdultDynamicUrl < DynamicUrl
      def initialize(context, sandbox)
        @context = context
        @sandbox = sandbox
      end

      def container_host
        if request.respond_to?(:mobile?) && request.mobile?
          @sandbox ? 'sba-netgame.dmm.com/fp/' : 'mobile-freegames.dmm.co.jp/'
        else
          @sandbox ? 'sba-netgame.dmm.com/sp/' : 'sp.dmm.co.jp/'
        end
      end

      def redirect
        {:format => :local}
      end
    end
  end
end
