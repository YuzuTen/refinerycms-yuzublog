module Refinery
  module Yuzublog
    module Admin
      class PostsController < ::Admin::BaseController
        crudify :'post',
          :order => 'created_at DESC',
          :xhr_paging => true
        alias_method :crudify_create, :create

        before_filter :set_active_user, :only=>[:create, :update]

        protected
        def set_active_user
          params[:post][:active_user]=current_user
        end

        def find_all_posts
          @blog=Blog.find(params['blog_id'])
          @posts=@blog.posts.order("publish_on DESC, created_at DESC")
        end

        public
        def drafts
          @list_type="Drafts"
          @posts=Post.where("aasm_state=?", :draft)
        end

        def new
          @blog=Blog.find(params['blog_id'])
          @post=@blog.posts.new(:active_user=>current_user)
          logger.info("Post: #{@post}")
        end

        def create
          @blog=Blog.find(params['blog_id'])
          @post=@blog.posts.create(params[:post])
          if @post.valid?
            (request.xhr? ? flash.now : flash).notice = t(
                'refinery.crudify.created',
                :what => "#{@post.title}"
            )
            unless from_dialog?
              unless params[:continue_editing] =~ /true|on|1/
                redirect_back_or_default(nil)
              else
                unless request.xhr?
                  redirect_to :back
                else
                  render :partial => '/refinery/message'
                end
              end
            else
                render :text => "<script>parent.window.location = '\#{#{options[:redirect_to_url]}}';</script>"
              end
            else
              unless request.xhr?
                render :action => 'new'
              else
                render :partial => "/refinery/admin/error_messages",
                       :locals => {
                         :object => @Post,
                         :include_object_name => true
                       }
              end
            end
        end
      end
    end
  end
end