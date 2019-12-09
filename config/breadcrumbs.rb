# ルート

crumb :root do
  link "fmarket", root_path
end

# マイページ
crumb :mypage do
  link 'マイページ', user_path
  parent :root
end

# ログアウト
crumb :sign_out do
  link 'ログアウト', destroy_user_session_path
  parent :mypage
end

# 商品詳細
crumb :product do 
  link "product.name", product_path
  parent :root
end


