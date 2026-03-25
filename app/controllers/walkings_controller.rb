class WalkingsController < ApplicationController
  include Rails.application.routes.url_helpers
  # 💡 JSからのPATCH通信を許可
  skip_before_action :verify_authenticity_token, only: [:save_progress, :update]

  def index
    @missions_with_photos = Mission.with_attached_image
                                   .where.not(walk_id: nil)
                                   .order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json {
        render json: @missions_with_photos.map { |m|
          { 
            id: m.id, 
            title: m.title, 
            image_url: m.image.attached? ? url_for(m.image) : nil 
          }
        }
      }
    end
  end

  def new
    @walk = current_user.walks.where(end_at: nil).order(created_at: :desc).first_or_create(
      start_at: Time.current, 
      steps: 0, 
      duration: 0
    )
    @current_mission = Mission.where(walk_id: nil).order("RANDOM()").first
    @captured_missions = @walk.missions.with_attached_image
  end

  def save_progress
    @walk = current_user.walks.find(params[:id])
    if @walk.update(walking_params)
      render json: { status: 'success' }, status: :ok
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end

  def update
    @walk = Walk.find(params[:id])
    
    steps = params[:steps].to_i
    duration_sec = params[:duration].to_i
    
    # 💡 経験値計算（一貫性のためここで計算して保存）
    mission_count = @walk.missions.count
    total_exp = (mission_count * 50) + ((steps / 100) * 10) + ((duration_sec / 60) * 5)

    if @walk.update(steps: steps, duration: duration_sec, end_at: Time.current)
      current_user.gain_exp(total_exp)
      # 💡 修正点：JS側が待っているのはリダイレクト先のURLです
      render json: { status: 'success', redirect_url: walking_path(@walk) }
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end

  def show
    @walk = Walk.find(params[:id])
    # 💡 リザルト画面で写真を表示するためにここで取得
    @captured_missions = @walk.missions.with_attached_image
    @mission_count = @captured_missions.count
    
    # Viewで使用する経験値の内訳を計算
    @mission_exp = @mission_count * 50
    @steps_exp = (@walk.steps / 100) * 10
    @time_exp = (@walk.duration / 60) * 5
    @total_exp = @mission_exp + @steps_exp + @time_exp
    
    # レベルアップ判定
    @is_level_up = current_user.level > (([current_user.exp - @total_exp, 0].max / 100) + 1)
  end

  def upload_image
    @walk = current_user.walks.find(params[:id])
    mission = Mission.find(params[:mission_id])

    if params[:image].present?
      mission.update(image: params[:image], walk_id: @walk.id)
      render json: { 
        status: 'success', 
        image_url: url_for(mission.image)
      }, status: :ok
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end

  private

  def walking_params
    if params[:walking].present?
      params.require(:walking).permit(:steps, :duration)
    else
      params.permit(:steps, :duration)
    end
  end
end