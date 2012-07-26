# -*- coding: utf-8 -*-

# Url 関係設定.
module OpensocialWap
  module Config
    class Url
      def self.configure(*args, &block)
        new(*args).tap{|o|o.instance_eval(&block)}
      end

      def initialize(context = nil)
        @context = context
      end

      def container_host(host = nil)
        if host
          @container_host = host
        end
        @container_host
      end

      def default(options = nil)
        if options
          @default = options
        end
        assure_container_host(@default)
      end

      def redirect(options = nil)
        if options
          @redirect = options
        end
        @redirect ? assure_container_host(@redirect) : default
      end

      def public_path(options = nil)
        if options
          @public_path = options
        end
        @public_path ? assure_container_host(@public_path) : default
      end

      private

      # options の :format が :full で、かつ :container_host が
      # 指定されていないときに、@container_host をセットする.
      def assure_container_host(options)
        if options[:format] == :full && options[:container_host].nil?
          options[:container_host] = container_host
        end
        options
      end
    end
  end
end
