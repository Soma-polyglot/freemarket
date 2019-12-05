# ルート
crumb :root do
  link "fmarket", root_path
end

# -------------------- マイページ関係 --------------------
# トップ
crumb :mypage do
  link 'マイページ', mypage_top_path
  parent :root
end

# ログアウト
crumb :mypage_logout do
  link 'ログアウト', mypage_logout_path
  parent :mypage
end

# ログアウト
crumb :mypage_profile do
  link 'プロフィール', mypage_profile_path
  parent :mypage
end

# ログアウト
crumb :mypage_identification do |item|
  link '本人情報の登録', mypage_identification_path
  parent :mypage
end


crumb :mypage_credit do
  link "支払い方法", mypage_card_index_path
  parent :mypage
end

crumb :credit_card_information do
  link "クレジットカード情報入力", new_mypage_card_path
  parent :mypage
end


# -------------------- 商品関係 --------------------
# 商品詳細
crumb :item do |item|
  link "#{item.name}", item_path(item)
  parent :root
end


