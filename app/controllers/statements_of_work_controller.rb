class StatementsOfWorkController < ApplicationController

  def show
    @statement_of_work = find_sow
    @submit_path = user_statement_of_work_path(@user.id, @statement_of_work.id)
  end

  def index
    @statements_of_work = @user.statements_of_work
  end

  def new
    @statement_of_work = StatementOfWork.new
    @submit_path = user_statements_of_work_path(@user.id)
  end

  def edit
    @statement_of_work = find_sow
    @submit_path = user_statement_of_work_path(@user.id, @statement_of_work.id)
  end

  def update
    @statement_of_work = find_sow
    @statement_of_work.update!(sow_params)
    redirect_to user_statement_of_work_path(@user.id, params[:id])
  end

  def create
    @statement_of_work = StatementOfWork.new(sow_params)
    @statement_of_work.user_id = @user.id
    @statement_of_work.save!
    redirect_to user_statements_of_work_path(@user.id)
  end

  def destroy
    @statement_of_work = find_sow
    @statement_of_work.destroy!
    redirect_to user_statements_of_work_path(@user.id)
  end

  def sow_params
    params.require(:statement_of_work).permit(:number, :purchase_order_number, :client, :nickname)
  end

  def find_sow
    StatementOfWork.find_by user_id: @user.id, id: params[:id]
  end
end
