class PasswordReferenceController < ApplicationController
  def ref_home


  end

  def do_ref_mail

    password = "error"
    student_id = params[:student_id]
    @item = Item.where(student_id: student_id)
    @item.each do |item|
      password =  item.pass
    end
    # メール通知
    if student_id.to_s == "818129298"
      email = "tsuku.byebuy@gmail.com"
    else
      email = student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
    end



    body = student_id.to_s + "様

これはパスワード照会用のメールです。

学籍番号:" + student_id.to_s + "

パスワード:" + password.to_s + "

※パスワードが Error と表示される場合はお手数ですがつくByeBuy運営まで連絡をお願いします。

このメールは筑波大学の講義「情報メディア実験B」での実習で作成されたものです。
心当たりが無い場合、他の人が誤って貴方の学籍番号を登録した可能性があります。
今後一切メールを受け取らないようにするには、大変お手数ですが下記のメールアドレスまでその旨の連絡をお願いいたします。

==========================
    つくByeBuy運営
tsuku.byebuy@gmail.com
==========================
"
    ActionMailer::Base.mail(from: "sg5td9uo@idcf.kke.com", to: email, subject: "[つくByeBuy]パスワード照会", body:body).deliver

  end


end
