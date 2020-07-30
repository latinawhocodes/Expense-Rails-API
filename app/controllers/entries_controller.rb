class EntriesController < ApplicationController

    def index 
        @entries = Entry.all 
        render json: @entries, except: [:created_at, :updated_at]
    end

    def show
        @expense = Expense.find_by(params[:id])
        @entries = @expense.entries.find_by(id: params[:id])
        render json: @entries, except: [:created_at, :updated_at]
    end

    def create 
        @entry = Entry.new(entry_params)

        if @entry.save
            render json: @entry, include: [:expense]
        else 
            render json: {message: "ERROR"}
        end
    end
    
    def update 
        @entry = Entry.find_by(params[:id])
        if @entry.update
            render json: @entry, except: [:created_at, :updated_at]
        else 
            render json: {message: "ERROR"}
        end 
    end 

    def destroy 
        @expense = Expense.find_by(params[:id])
        @entry = Entry.find_by(params[:id])
        @entry.destroy 
    end 

    private
    def entry_params
        params.require(:entry).permit(:amount, :description, :date, :expense_id)
    end
end
