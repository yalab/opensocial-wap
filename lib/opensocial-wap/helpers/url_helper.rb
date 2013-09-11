# -*- coding: utf-8 -*-

# ActionView::Helpers::UrlHelper を拡張.
module OpensocialWap
  module Helpers
    module UrlHelper
      include ::OpensocialWap::Routing::UrlFor
      include Base

      # url_for for the OpenSocial WAP Extension.
      #
      # url_settings 引数が nil か false である場合、本来の実装による url_for を実行する.
      #
      # url_settings 引数に有効な値が指定されていれば、拡張 url_for を呼び出す.
      # url_settings は、下記の場所で指定することができる.
      # * url_for の url_settings 引数.
      # * Rails.application.config.opensocial_wap[:url] の値(初期化時に指定).
      # 優先順位は上の方が高い.
      #
      def url_for(options = nil, url_settings = nil) # :nodoc:
        unless url_settings
          return super(options) # 本来の実装.
        end

        case options
        when :back
          _back_url
        else
          # OpensocialWap::Routing::UrlFor の url_for を呼び出す.
          super(options, url_settings)
        end
      end


      # link_to for the OpenSocial WAP Extension.
      #
      # イニシャライザ、コントローラでの設定に基づいて、OpenSocial WAP用URLをセットする.
      # html_options引数に、:url_settings というキーで値を指定して、URL書き換え設定を上書きすることができる.
      # なお、link_to_if, link_to_unless, link_to_unless_current にも本拡張の影響は及ぶ(内部で link_to を呼んでいるため).
      def link_to(name = nil, options = nil, html_options = nil, &block)
        html_options, options = options, name if block_given?
        options ||= {}

        html_options = convert_options_to_data_attributes(options, html_options)

        url_settings = extract_url_settings(html_options)
        url = url_for(options, url_settings) # url_settings 引数付きで url_for 呼び出し.
        html_options['href'] ||= url

        content_tag(:a, name || url, html_options, &block)
      end

      # button_to for the OpenSocial WAP Extension.
      #
      # イニシャライザ、コントローラでの設定に基づいて、OpenSocial WAP用URLをセットする.
      # html_options引数に、:url_settings というキーで値を指定して、URL書き換え定を上書きすることができる.
      def button_to(name = nil, options = nil, html_options = nil, &block)
        html_options, options = options, name if block_given?
        options      ||= {}
        html_options ||= {}

        html_options = html_options.stringify_keys
        convert_boolean_attributes!(html_options, %w(disabled))

        # url    = options.is_a?(String) ? options : url_for(options)
        url_settings = extract_url_settings(html_options)
        url          = url_for(options, url_settings)

        remote = html_options.delete('remote')

        method     = html_options.delete('method').to_s
        method_tag = %w{patch put delete}.include?(method) ? method_tag(method) : ''.html_safe

        form_method  = method == 'get' ? 'get' : 'post'
        form_options = html_options.delete('form') || {}
        form_options[:class] ||= html_options.delete('form_class') || 'button_to'
        form_options.merge!(method: form_method, action: url)
        form_options.merge!("data-remote" => "true") if remote

        request_token_tag = form_method == 'post' ? token_tag : ''

        html_options = convert_options_to_data_attributes(options, html_options)
        html_options['type'] = 'submit'

        button = if block_given?
          content_tag('button', html_options, &block)
        else
          html_options['value'] = name || url
          tag('input', html_options)
        end

        inner_tags = method_tag.safe_concat(button).safe_concat(request_token_tag)
        content_tag('form', content_tag('div', inner_tags), form_options)
      end

      private

      # html_options から Opensocial WAP用オプションを取り出す.
      def extract_url_settings(html_options)
        url_settings = nil
        if html_options
          url_settings = html_options.delete("url_settings")
        end
        if !url_settings && default_url_settings
          # コントローラで opensocial_wap が呼ばれていれば、url_settings を有効にする.
          # link_to, button_to 系では、:default の設定を使用する.
          if default_url_settings.kind_of? Proc
            url_settings = default_url_settings.call(self)
          else
            url_settings = default_url_settings
          end
          url_settings = url_settings.default
        end
        url_settings
      end

    end
  end
end
