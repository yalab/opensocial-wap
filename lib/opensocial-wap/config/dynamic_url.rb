# -*- coding: utf-8 -*-

# Url 関係設定.
module OpensocialWap
  module Config
    #
    # 実行時にURLを決定したいときの設定
    #
    # かなり決め打ちだけど変更したかったらサブクラスを作ればいい
    # 引数を受け取ってそれを返すなら動的にした意味がないので普通の静的な方を使えばいい
    #
    class DynamicUrl
      def initialize(context)
        @context = context
      end

      def container_host
        if request.mobile? && request.user_agent.to_s.match(/test/i)
          "ma.test.mixi.net"
        else
          "ma.mixi.net"
        end
      end

      def default
        if request.mobile?
          {:format => :query, :params => {:guid => "ON"}}
        else
          {:format => :local}
        end
      end

      def redirect
        if request.respond_to?(:mobile?) && request.mobile?
          {:format => :full, :params => {:guid => "ON"}, :container_host => container_host}
        else
          {:format => :local}
        end
      end

      def public_path
        {:format => :local}
      end

      private

      #
      # @context は controller を想定している
      # しかし呼び出す側が request の中で self を渡したい場合もある
      # そうなると Object.new.request みたいなものを作らないといけなくて面倒
      # かといって呼び出し側で毎回 controller.request と書きたくない
      # のでこっちの request メソッドで吸収する
      #
      def request
        if @context.respond_to?(:request)
          @context.request
        else
          @context
        end
      end
    end
  end
end
