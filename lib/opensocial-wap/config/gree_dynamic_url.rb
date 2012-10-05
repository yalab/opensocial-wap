# -*- coding: utf-8 -*-

# Url 関係設定.
module OpensocialWap
  module Config
    #
    # 実行時にURLを決定したいときの設定 Gree
    #
    class GreeDynamicUrl < DynamicUrl
      def initialize(context, sandbox)
        @context = context
        @sandbox = sandbox
      end

      def container_host
        if request.respond_to?(:mobile?) && request.mobile?
          @sandbox ? 'mgadget-sb.gree.jp' : "mgadget.gree.jp"
        else
          @sandbox ? 'pf-sb.gree.jp' : 'pf.gree.jp'
        end
      end

      def redirect
        {:format => :local}
      end
    end
  end
end
