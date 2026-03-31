# db/seeds.rb

# 既存のデータをリセット
Mission.destroy_all
Character.destroy_all
UserCharacter.destroy_all

# 1. 写真が必要なミッション (requires_photo: true)
photo_missions = [
  "赤いポストを撮ろう",
  "自動販売機のボタンを撮ろう",
  "カーブミラーの中の自分を撮ろう",
  "マンホールの蓋を撮ろう",
  "黄色い看板を撮ろう",
  "「止まれ」の標識を撮ろう",
  "季節の花を撮ろう",
  "公園のベンチを撮ろう",
  "面白い形の雲を撮ろう",
  "自転車の車輪を撮ろう"
].map { |t| { title: t, requires_photo: true } }

# 2. 写真不要 行動・発見ミッション (requires_photo: false)
action_missions = [
  "一番近くの「橋」を渡り切ろう", 
  "大きな通りに出るまで、<br>ひたすら真っ直ぐ歩こう", 
  "公園にたどり着くまで歩こう",
  "今から5分間、<br>一度も曲がらずに歩き続けてみよう",
  "「郵便局」か「コンビニ」を<br>見つけるまで歩いてみよう",
  "一番近い「信号機」がある<br>交差点まで行ってみよう",
  "どこかの「ベンチ」を見つけて、<br>3分間座って休憩しよう",
  "川や線路沿いなど、<br>見晴らしの良い場所まで歩こう",
  "今まで通ったことのない<br>「細い道」を選んで進んでみよう",
  "10分間、風を感じながら歩こう<br>（タイマー開始！）"
].map { |t| { title: t, requires_photo: false } }

# 3. ミッションをデータベースに登録
(photo_missions + action_missions).each do |m|
  Mission.create!(m)
end

puts "✅ 合計 #{Mission.count} 個のミッションを登録しました！"

# 4. キャラクターデータ「金宵（こよい）」の登録
koyoi = Character.create!(
  name: "金宵 (こよい)",
  description: "夜の静寂を好む、非常に知恵の回る子狐。主の歩みに合わせて無邪気に跳ねているように見えるが、実はその歩幅やリズムを微妙に狂わせて楽しむといった、いたずら好きな一面がある。物事の真理を悟ったような高い知性を備えているが、退屈を何よりも嫌う性分である。",
  description_v2: "幾千の夜を越え、本来の威厳ある姿を取り戻した妖狐。その瞳には過去と未来のすべてが映ると伝承されている。姿は雅に変化したが、主をからかって反応を見ることを好むお茶目な気質は変わっていない。主がミッションに奔走する姿を、扇で口元を隠しながら密かに観察している。",
  image_v1: "characters/金宵_v1.png",
  image_v2: "characters/金宵_v2.png",
  rarity: 5,
  evolution_level: 10
)

# 5. 開発用：最初のユーザーに「金宵」を付与
user = User.first
if user
  UserCharacter.create!(
    user: user, 
    character: koyoi,
    evolved: false
  )
end

puts "✅ キャラクターの登録とユーザーへの付与が完了しました！"