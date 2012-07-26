# -*- coding: utf-8 -*-

# OAuth 関係設定.
module OpensocialWap
  module Config
    module OAuth
      # Singleton Pattern
      extend self

      def configure(&block)
        instance_eval(&block)
        self
      end

      def helper_class(klass = nil)
        if klass
          @helper_class = klass
        end
        @helper_class
      end
    end
  end
end
