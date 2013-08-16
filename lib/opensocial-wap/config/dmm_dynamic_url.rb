# -*- coding: utf-8 -*-

# Url 関係設定.
module OpensocialWap
  module Config
    #
    # 実行時にURLを決定したいときの設定 Dmm Adult
    #
    class DmmDynamicUrl < DynamicUrl
      def initialize(context, sandbox)
        @context = context
        @sandbox = sandbox
      end

      def container_host
        if request.respond_to?(:mobile?) && request.mobile?
          @sandbox ? 'sbg-netgame.dmm.com/fp/' : 'mobile-freegames.dmm.com/'
        else
          @sandbox ? 'sbg-netgame.dmm.com/sp/' : 'sp.dmm.com/'
        end
      end

      def redirect
        {:format => :local}
      end
    end
  end
end
