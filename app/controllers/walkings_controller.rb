class WalkingsController < ApplicationController
  def new
    # 最初のお題を1つセットしておく
    @current_mission = Mission.order("RANDOM()").first
  end

  def create
    # お散歩終了時の保存処理をあとで書きます
  end

  # 💡 追加：JavaScriptから呼ばれるランダムお題取得用
  def random_mission
    @mission = Mission.order("RANDOM()").first
    render json: { title: @mission.title }
  end
end