module Refinery
  module Yuzublog
    module Admin
      class BlogsController < ::Admin::BaseController
        # unloadable
        #helper 'refinery/yuzublog/admin/settings'

        crudify :'blog',
          :order => 'name ASC',
          #:redirect_to_url =>:redirect_to_where?
          :xhr_paging => true

        def new
          @blog = ::Blog.new() #punting on :form_value_type => form_value_type for now
          @users=User.all
        end

        def edit
          @blog = ::Blog.find(params[:id])
          @users=User.all
          render :layout => false if request.xhr?
        end
      end
    end
  end
end