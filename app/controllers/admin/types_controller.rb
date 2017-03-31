module Admin

  class TypesController < ApplicationController

    before_action :set_types, only: [:update, :edit, :destroy]

    def index
      @types = Type.all
    end

    def new
      @types = Type.new
    end

    def create
      @types = Type.new(types_params)
      if @types.save
        redirect_to({action: :index}, success: "Un nouveau Type a bien été créé")
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @types.update(types_params)
        redirect_to({action: :index}, success: "Le Type a bien été modifiée")
      else
        render :new
      end
    end

    def destroy
      @types.destroy
      redirect_to({action: :index}, success: "Le Type a bien été supprimée")
    end

    private

    def types_params
      params.require(:type).permit(:slug, :name)
    end

    def set_types
      @types = Type.find(params[:id])
    end

  end

end