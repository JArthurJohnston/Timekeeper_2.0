class StatementsOfWorkController < ApplicationController

  def show
    @statement_of_work = find_sow
  end

  def sow_params

  end

  def find_sow
    StatementOfWork.find_by user_id: @user.id, id: params[:id]
  end
end
