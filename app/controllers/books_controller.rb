class BooksController < ApplicationController

  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = current_user.books
  end

  def new
    @book = current_user.books.new
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to books_path, success: 'Votre livre a bien été crée'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to books_path, success: 'Votre livre a bien été modifié'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, success: 'Votre livre a bien été supprimé'
  end

  private

  def book_params
    params.require(:book).permit(:name,:publication, :type_id, :cover)
  end

  def set_book
    @book = current_user.books.find(params[:id])
  end

end