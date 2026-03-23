class WalksController < ApplicationController
  # お散歩開始（レコード作成）
  def create
    @walk = Walk.create(start_at: Time.current, steps: 0)
    # 作成したWalkのIDをお散歩画面に渡す
    redirect_to new_walking_path(walk_id: @walk.id)
  end

  # お散歩終了（データ更新）
  def update
    @walk = Walk.find(params[:id])
    if @walk.update(walk_params)
      render json: { status: 'success' }
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end

  private

  def walk_params
    params.require(:walk).permit(:end_at, :steps, :duration, :distance)
  end
end