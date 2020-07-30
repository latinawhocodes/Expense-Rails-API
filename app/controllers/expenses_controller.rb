class Api::ExpensesController < ApplicationController

    def index
        @expenses = Expense.all 
        render json: @expenses, except: [:created_at, :updated_at]
    end

    def show 
        @expense = Expense.find_by(params[:id])
        render json: @expenses, except: [:created_at, :updated_at]
    end

    def create 
        @expense = Expense.new(expense_params)

        if @expense.save 
            render json: @expense, except: [:created_at, :updated_at]
        else 
            render json: {message: "ERROR"}
        end
    end

    def destroy 
        @expense = Expense.find_by(params[:id])
        @expense.destroy
    end

    private 
    def expense_params
        params.require(:expense).permit(:category)
    end

end
