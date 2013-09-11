require 'opensocial-wap/config/oauth'
require 'opensocial-wap/config/url'
require 'opensocial-wap/config/dynamic_url'
require 'opensocial-wap/config/gree_dynamic_url'
require 'opensocial-wap/config/mobage_dynamic_url'
require 'opensocial-wap/config/dmm_dynamic_url'
require 'opensocial-wap/config/dmm_adult_dynamic_url'
require 'opensocial-wap/oauth/helpers/base'
require 'opensocial-wap/oauth/request_proxy/oauth_rack_request_proxy'
require 'opensocial-wap/oauth/request_proxy/oauth_rack_request_proxy_for_gree'
require 'opensocial-wap/oauth/helpers/basic_helper'
require 'opensocial-wap/oauth/helpers/gree_helper'
require 'opensocial-wap/oauth/helpers/mobage_helper'
require 'opensocial-wap/oauth/client_helper'
require 'opensocial-wap/oauth/client/helper'

require 'opensocial-wap/routing/url_formatter'
require 'opensocial-wap/rack/opensocial_oauth'
require 'opensocial-wap/rack/request'

require "active_support/core_ext/object"
require "active_support/core_ext/string"
require "active_support/core_ext/array"
require "active_support/core_ext/hash"

if defined?(::Rails::Railtie)
  if Rails.version < '4'
    class OpensocialWapError < StandardError; end
    raise OpensocialWapError, "OpenspcialWap #{OpensocialWap::VERSION} does not support Rails version < 4.0"
  end
  require 'opensocial-wap/railtie'
end

module OpensocialWap
end
