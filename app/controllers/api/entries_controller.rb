class Api::EntriesController < ApplicationController

    def index
        get_expense
        @entries = Entry.all 
        render json: @entries, include: [:expense], except: [:created_at, :updated_at]
    end

    def show 
        get_expense
        @entries = @expense.entries.find_by(id: params[:id])
        render json: @entries, include [:expense], except: [:created_at, :updated_at]
    end

    def create 
        @entry = @expense.entries.build(entry_params)
        
        if @entry.save
            render json: @entry, include: [:expense], except: [:created_at, :updated_at]
        else 
            render json: {message: "ERROR"}
        end
    end

    def update 
        find_entry
        if @entry.update
            render json: @entry, include: [:expense], except: [:created_at, :updated_at]
        else 
            render json: {message: "ERROR"}
        end
    end

    def destroy 
        get_expense
        find_entry
        @expense = Expense.find(@entry.expense_id)
        @entry.destroy
    end 

    private 
    def find_entry
        @entry = Entry.find_by(params[:id])
    end

    def get_expense
        @expense = Expense.find(params[:id])
    end

    def entry_params
        params.require(:entry).permit(:amount, :description, :date, :expense_id)
    end
end
