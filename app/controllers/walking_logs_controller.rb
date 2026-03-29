class WalkingLogsController < ApplicationController
  def index
    # 1. 完了したすべての散歩データを取得
    all_walks = current_user.walks.where.not(end_at: nil).order(end_at: :desc)
    
    # 2. 日付ごとにグループ化して、合計値を計算した配列を作る
    @dates = all_walks.group_by { |w| w.end_at.to_date }.map do |date, walks|
      {
        date: date,
        # 💡 ここを修正！ nilが入っていても 0 として扱うようにします
        total_steps: walks.sum { |w| w.steps || 0 },
        total_duration: walks.sum { |w| w.duration || 0 },
        walk_count: walks.count
      }
    end
  end

  # 日付をタップした先の「その日の内訳」
  def date_index
    # 💡 もし date パラメータがなくても、今日の日付を身代わりに立ててエラーを防ぐ
    @target_date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    
    @walking_logs = current_user.walks
                                .where(end_at: @target_date.beginning_of_day..@target_date.end_of_day)
                                .order(end_at: :desc)
  end

  def show
    # 💡 URLは /walking_logs/176 だけど、探すデータは Walk モデルから！
    @walking_log = Walk.find(params[:id])
    @captured_missions = @walking_log.missions.with_attached_image
  end
end