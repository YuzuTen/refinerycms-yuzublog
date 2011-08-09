module Refinery
  module Yuzublog
    module Admin
      class BlogsController < ::Admin::BaseController
        unloadable
        crudify :'blog',
          :xhr_paging => true, :title_attribute=>'name'

        before_filter :load_users
        before_filter :load_sites
        before_filter :autoassign_site

        protected
        def load_users
          @users=User.all
        end

        def load_sites
          @sites=Site.all
        end

        def autoassign_site
          if params[:site_id].present?
            params[:blog][:site_id]=params[:site_id]
            @autoassigned_site=true
          else
            @autoassigned_site=false
          end

        end

        public
        def find_all_blogs
          @blogs=Blog.joins(:site).includes(:site).order("sites.name, blogs.name")
        end

        def new
          @blog = ::Blog.new() #punting on :form_value_type => form_value_type for now
        end

        def edit
          @blog = ::Blog.find(params[:id])
          render :layout => false if request.xhr?
        end
      end
    end
  end
end