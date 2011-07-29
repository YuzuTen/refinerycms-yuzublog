module Refinery
  module Yuzublog
    module Admin
      class BlogsController < ::Admin::BaseController
        unloadable
        before_filter :load_users

        protected
        def load_users
          @users=User.all
        end
        #helper 'refinery/yuzublog/admin/settings'
        public
        crudify :'blog',
          :order => 'name ASC',
          #:redirect_to_url =>:redirect_to_where?
          :xhr_paging => true, :title_attribute=>'name'

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