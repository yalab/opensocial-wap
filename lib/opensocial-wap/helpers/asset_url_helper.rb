# -*- coding: utf-8 -*-

# ActionView::Helpers::AssetTagHelper を拡張.
module OpensocialWap
  module Helpers
    module AssetUrlHelper
      include UrlHelper
      include ::ActionView::Helpers::AssetTagHelper

      # compute_asset_path を上書き.
      # 初期化時に、opensocial_wap[:url] でURL形式が指定されていれば、パスを
      # OpenSocial 用のものに書き換える.
      def compute_asset_path(source = "", options = {})
        path = super
        if defined? config.asset_host && config.asset_host.present?
          # asset_hostが設定されている場合は処理しない
        else
          if default_url_settings
            # public_path で指定されているオプションを使用する.
            if default_url_settings.kind_of? Proc
              url_settings = default_url_settings.call(self).public_path
            else
              url_settings = default_url_settings.public_path
            end
            path = url_for(path, url_settings)
          end
        end

        path
      end

    end
  end
end
