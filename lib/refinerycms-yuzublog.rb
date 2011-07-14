require 'refinerycms-base'

module Refinery
  module Yuzublog
    autoload :Version, File.expand_path('../refinerycms-yuzublog/version', __FILE__)

    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end
    end

    class Engine < ::Rails::Engine

      initializer "init plugin", :after => :set_routes_reloader do |app|
        ::Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name= "refinery_yuzublog"
          plugin.url = app.routes.url_helpers.refinery_admin_blogs_path
          plugin.version= Refinery::Yuzublog::Version
          plugin.menu_match = /refinery\/yuzublog$/
        end
      end
    end
  end
end
#::Refinery.engines << 'yuzublog'

