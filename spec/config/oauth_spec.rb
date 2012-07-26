require 'spec_helper'

module OpensocialWap
  module Config
    describe OAuth do
      it do
        config = OpensocialWap::Config::OAuth.configure do
          OpensocialWap::OAuth::Helpers::BasicHelper.configure do
            consumer_key    '(consumer_key)'
            consumer_secret '(consumer_secret)'
            api_endpoint    'http://api.example.com/'
          end
          helper_class OpensocialWap::OAuth::Helpers::BasicHelper
        end

        config.helper_class.should == OpensocialWap::OAuth::Helpers::BasicHelper
        config.helper_class.consumer_key.should == '(consumer_key)'
        config.helper_class.consumer_secret.should == '(consumer_secret)'
        config.helper_class.api_endpoint.should == 'http://api.example.com/'
      end
    end
  end
end
