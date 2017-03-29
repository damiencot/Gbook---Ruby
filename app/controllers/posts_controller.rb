class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  skip_before_action :only_signed_in, only: [:types, :index, :show]

  # GET /posts
  # GET /posts.json
  def index
    book_ids = current_user.followed_books.pluck(:id)
    if book_ids.empty?
      @posts = []
    else
      @posts = Post.joins('INNER JOIN books_posts ON books_posts.post_id = posts.id').where("books_posts.book_id IN (#{book_ids.join(',')})")
    end
  end

  def types
    @types = Type.find_by_slug!(params[:slug])
    @posts = Post.joins(:books).where(books: {type_id: @types.id})
  end

  def me
    @posts = current_user.posts.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_user.posts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      b = params.require(:post).permit(:name, :content, :image, book_ids: [])
      b[:book_ids] = current_user.books.where(id: b[:book_ids]).pluck(:id)
      b
    end
end
