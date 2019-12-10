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
crumb :product do |product_item|
  product_item = Product.find_by(id: params[:id])
  link product_item.name, product_path
  parent :root
end

# プロフィール
crumb :profile do 
  link "プロフィール", edit_user_path
  parent :mypage
end


