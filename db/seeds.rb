# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Animal.destroy_all
Human.destroy_all

# 動物名、サイズ、メモの候補データ
animal_names = ["ライオン", "ウサギ", "ゾウ", "ネコ", "イヌ", "キリン", "ハムスター", "トラ", "クジラ", "カンガルー",
                "パンダ", "コアラ", "シカ", "ペンギン", "サイ", "ラクダ", "オオカミ", "フクロウ", "アシカ", "ワシ",
                "ゴリラ", "チーター", "アルパカ", "リス", "カメ", "イタチ", "ヤギ", "ブタ", "シロクマ", "ホッキョクギツネ",
                "ヘビ", "カワウソ", "タカ", "ヒツジ", "ムササビ", "カラス", "トカゲ", "バク", "ウマ", "ロバ",
                "キツネ", "カピバラ", "アリクイ", "オットセイ", "ビーバー", "サル", "イグアナ", "ダチョウ", "ホッキョクグマ"]

sizes = ["S", "M", "L", "LL"]
memos = [
  "草食動物", "肉食動物", "雑食性", "人懐っこい", "非常に大きい", "小型でかわいい", "長寿で知られる", "水中生活", "陸上で活動", 
  "夜行性", "珍しい動物", "危険な動物", "温厚な性格", "絶滅危惧種", "走るのが速い", "泳ぐのが得意", "飛ぶことができる", 
  "寒冷地に生息", "暑い地域に多い", "ペットとして人気", "特殊な生態", "俊敏な動き", "首が長い", "耳が大きい", "力持ち"
]

# 50件の動物データを生成
50.times do |i|
  Animal.create!(
    name: animal_names.sample,
    size: sizes.sample,
    memo: memos.sample,
    number: i+1
  )
end

# 名字と名前の候補データ
first_names = ["太郎", "次郎", "花子", "美咲", "大輔", "直樹", "絵里", "沙織", "雄大", "陽子", "翔太", "恵子", "拓海", "遥", "智也",
               "由美", "一郎", "智子", "真由美", "亮太", "翔", "優子", "慎一", "明美", "仁", "春菜", "大樹", "優輝", "悠", "愛子", "大和"]

last_names = ["田中", "鈴木", "佐藤", "高橋", "伊藤", "山本", "中村", "小林", "加藤", "吉田", "佐々木", "山田", "松本", "井上", "清水",
              "渡辺", "竹内", "岡田", "村上", "斎藤", "石井", "大野", "森", "長谷川", "池田", "金子", "中川", "小川", "西田", "藤田", "坂本"]

# メモの候補データ
human_memos = [
  "優しい", "社交的", "読書好き", "スポーツ好き", "音楽好き", "映画好き", "料理が得意", "人懐っこい", "積極的", "おおらか",
  "几帳面", "おしゃれ", "旅行好き", "インドア派", "アウトドア派", "動物好き", "お笑い好き", "テクノロジーに興味がある", "絵を描くのが得意",
  "歴史好き", "科学に興味がある", "宗教に関心がある", "政治に関心がある", "アートに興味がある", "ボランティア活動に参加している", 
  "マラソンをしている", "ゲーム好き", "お酒が好き", "甘いものが好き", "料理が好き", "食べ歩きが趣味", "健康志向", "家事全般得意",
  "犬を飼っている", "猫を飼っている", "子どもが好き", "映画鑑賞が趣味", "アウトドアが好き", "インディーズ音楽を好む", "お酒は強い", 
  "フリーランスで働いている", "自己啓発に興味がある", "異文化交流に興味がある", "座右の銘は「努力は裏切らない」", "夢は世界一周旅行", 
  "将来は起業したい", "最近ダイエット中", "アニメ好き", "手作りアクセサリーを作っている", "ギターを弾く", "海外留学経験がある"
]

# 50件の人間データを生成
50.times do |i|
  Human.create!(
    name: "#{last_names.sample} #{first_names.sample}",
    size: rand(150..190),
    memo: human_memos.sample,
    number: i+1
  )
end