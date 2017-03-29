class SubscriptionsController < ApplicationController

  before_action do
    @book = Book.find(params[:book_id])
  end

  def create
    @book.subscribers << current_user
    redirect_to @book, success: 'Vous êtes maintenant abonné à ' + @book.name
  end

  def destroy
    @book.subscribers.delete(current_user)
    redirect_to @book, success: 'Vous êtes maintenant désabonné à ' + @book.name
  end

end