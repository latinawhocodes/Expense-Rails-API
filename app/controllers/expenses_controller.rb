class ExpensesController < ApplicationController

    def index 
        @expenses = Expense.all 
        render json: @expenses, except: [:created_at, :updated_at]
    end

    def show 
        find_expense
        render json: @expense, except: [:created_at, :updated_at]
    end

    def create 
        @expense = Expense.create(expense_params)

        if @expense.save
            render json: @expense, except: [:created_at, :updated_at]
        else 
            render json: {message: "ERROR"}
        end
    end

    def update 
        find_expense

        if @expense.update(expense_params)
            render json: @expense, except: [:created_at, :updated_at]
        else
            render json: {message: "ERROR"}
        end
    end

    def destroy 
        find_expense
        @expense = Expense.find_by(params[:id])
    end

    private 
    def find_expense
        @expense = Expense.find(params[:id])
    end

    def expense_params
        params.require(:expense).permit(:category)
    end
    

end
