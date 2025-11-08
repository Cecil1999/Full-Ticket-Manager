class PostsController < ApplicationController
  before_action :set_ticket

  def index
    render json: { r: @ticket.posts }
  end

  def show
    render json: { r: @ticket.posts.find(params[:id]) }
  end

  def create
    @post = @ticket.posts.build(post_params)
    if @post.save
      render json: { r: "Post Successfully Created." }
    else
      render json: { e: @post.errors }, status: 403
    end
  end

  def update
    @post = @ticket.posts.find(params[:id])

    if @post.update(post_params)
      render json: { r: "Post Successfully Updated. " }
    else
      render json: { e: @post.errors }, status: 403
    end
  end

  def destroy
    @post = @ticket.posts.find(params[:id])

    @post.show = "FALSE"
    if @post.save
      render json: { r: "Post Successfully Deleted" }
    else
      render json: { e: @post.errors }
    end
  end

  private
  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def post_params
   params.expect(post: [ :body ])
  end
end
