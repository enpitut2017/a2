class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.order('created_at DESC').where(activated: true)
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])
    @comments = @item.comments.all
    @comment = @item.comments.build
    if @item.sold == 8181
      redirect_to action: "sold",id: @item.id
    end
  end

  def sold
    @item = Item.find(params[:id])
    @comments = @item.comments.all
    @comment = @item.comments.build
  end

  def comment
    @item = Item.find(params[:item_id])
    password = params[:password]
    commentCh=params[:commentCh]
    judge = "3"
    c_error = "0"

    if password == @item.pass || password == ENV['MASTER_PASS'] then
      judge = "1"
    elsif commentCh == "s2"
      judge = "2"
      if password == "" then
        flash[:alert] = "※※※パスワードを入力してください。"
      else
        flash[:alert] = "※※※パスワードが間違っています。"
      end
    elsif commentCh == "s1" then
      judge = "0"
    end

    if params[:comment_body].empty?
      c_error = "0"
      flash[:alert] = "※※※空欄のままでは送信できません。"
    else
      c_error = "1"
    end

    if judge == "2" || c_error == "0" then
      if params[:choice_c] != "0" then
        flash[:choice_c] = params[:choice_c]
        flash[:return_comment] = params[:choice_c].to_s + "への返信"
        flash[:null] = "1"
      end
      redirect_to action:  "show", id: params[:item_id], anchor: 'com'
    end

    if (judge == "1"  || judge == "0") && c_error == "1" then

      @comment = Comment.new(comment_body: params[:comment_body], item_id: params[:item_id],reply: params[:choice_c],judge: judge)
      @comment.save

      #log
      log_file = File.open('./app/assets/log_file.txt', 'a')
      log_file.puts "************************"
      log_file.puts Time.current
      log_file.puts "<コメント>"
      log_file.puts "商品ID: " + params[:item_id].to_s
      if commentCh == "s1" then
        log_file.puts "[購入者のコメント]"
      elsif commentCh == "s2" then
        log_file.puts "[出品者のコメント]"
      end
      if params[:choice_c].to_s == "0" then
        log_file.puts "[返信なし]"
      else
        log_file.puts "[" + params[:choice_c].to_s + "への返信]"
      end
      log_file.puts "コメント内容: " + params[:comment_body].to_s
      log_file.close

      redirect_to :action => "show", :id => @comment.item_id, :anchor => 'com'
      if @comment.save
        if @comment.judge == "0"
          @item = Item.find(params[:item_id])

          if @item.student_id.to_s == "818129298"
            email = "tsuku.byebuy@gmail.com"
          else
            email = @item.student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
          end
          body = @item.student_id.to_s + "様


出品した商品に新しくコメントが届きました。
以下のリンクから返信フォームをご利用ください。

https://tsukubyebuy.herokuapp.com/items/" + @item.id.to_s + "
商品名:" + @item.name.to_s + "
コメント内容:" + @comment.comment_body.to_s + "

==========================
      つくByeBuy運営
  tsuku.byebuy@gmail.com
==========================
"
          ActionMailer::Base.mail(from: "sg5td9uo@idcf.kke.com", to: email, subject: "[つくByeBuy]新着コメント", body:body).deliver
        end
      end
    end
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    #log
    log_file = File.open('./app/assets/log_file.txt', 'a')
    log_file.puts "************************"
    log_file.puts Time.current
    log_file.puts "<商品編集完了>"
    log_file.puts "商品ID: " + @item.id.to_s
    log_file.puts "商品名: " + @item.name.to_s
    log_file.puts "場所ID: " + @item.place_id.to_s
    log_file.puts "商品画像: " + @item.image.url.to_s
    log_file.puts "商品価格: " + @item.price.to_s
    log_file.puts "商品詳細: " + @item.detail.to_s
    log_file.puts "ジャンルID: " + @item.genre_id.to_s
    log_file.puts "出品者学籍番号: " + @item.student_id.to_s
    log_file.close
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    items = Item

    #log
    log_file = File.open('./app/assets/log_file.txt', 'a')
    log_file.puts "************************"
    log_file.puts Time.current
    log_file.puts "<仮出品完了>"
    log_file.puts "商品ID: " + @item.id.to_s
    log_file.puts "商品名: " + @item.name.to_s
    log_file.puts "場所ID: " + @item.place_id.to_s
    log_file.puts "商品画像: " + @item.image.url.to_s
    log_file.puts "商品価格: " + @item.price.to_s
    log_file.puts "商品詳細: " + @item.detail.to_s
    log_file.puts "ジャンルID: " + @item.genre_id.to_s
    log_file.puts "出品者学籍番号: " + @item.student_id.to_s
    log_file.close

    pass_check = "0"
    id_i = 1
    while id_i <= Item.last.id do
      @it = Item.find_by(:id => id_i)
      if @it != nil
        if @it.student_id == @item.student_id
          @item.pass = @it.pass
          pass_check = "1"
        end
      end
      id_i += 1
    end
    if pass_check == "0"
      num = ('0'..'9').to_a
      @item.pass = Array.new(4){num[rand(num.size)]}.join
    end

    @item.activated = false
    if @item.save
      # トークン生成
      @token = SecureRandom.uuid
      @item.tokens.create!(uuid: @token, expired_at: 24.hours.since)
      # メール通知
      if @item.student_id.to_s == "818129298"
        email = "tsuku.byebuy@gmail.com"
      else
        email = @item.student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
      end
      body = @item.student_id.to_s + "様

出品を受付ました。

商品名:" + @item.name.to_s + "

出品を完了するには次のURLへのアクセスをお願いします。
https://tsukubyebuy.herokuapp.com/items/" + @item.id.to_s + "/token/" + @token + "

このメールは筑波大学の講義「情報メディア実験B」での実習で作成されたものです。
心当たりの無い場合は誤送ですので、無視していただければと思います。申し訳ありません。

==========================
enPiT2017 チームA1
tsuku.byebuy@gmail.com
==========================
"

      ActionMailer::Base.mail(from: "sg5td9uo@idcf.kke.com", to: email, subject: "[つくByeBuy]出品完了", body:body).deliver
      respond_to do |format|
        flash[:notice] = "商品の仮登録が完了し、学生用メールアドレスにメールが送信されました。メールを確認して本登録を完了してください。"
        format.html { redirect_to @item}
        format.json { render :show, status: :created, location: @item }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def token
    # 有効期限の確認
    token = Token.find_by_uuid!(params[:uuid])
    # 有効期限を過ぎていないか確認
    if token && token.expired_at > Time.now
      # 2回目アクセスできないように更新
      token.update_attributes!(expired_at: Time.now)
      @item = token.item
      @item.update_attributes!(activated: true)

      # log
      log_file = File.open('./app/assets/log_file.txt', 'a')
      log_file.puts "************************"
      log_file.puts Time.current
      log_file.puts "<出品完了>"
      log_file.puts "商品ID: " + @item.id.to_s
      log_file.puts "商品名: " + @item.name.to_s
      log_file.puts "場所ID: " + @item.place_id.to_s
      log_file.puts "商品画像: " + @item.image.url.to_s
      log_file.puts "商品価格: " + @item.price.to_s
      log_file.puts "商品詳細: " + @item.detail.to_s
      log_file.puts "ジャンルID: " + @item.genre_id.to_s
      log_file.puts "出品者学籍番号: " + @item.student_id.to_s
      log_file.close

      # 登録完了メール通知
      if @item.student_id.to_s == "818129298"
        email = "tsuku.byebuy@gmail.com"
      else
        email = @item.student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
      end
      body = @item.student_id.to_s + "様

出品が完了しました。
あなたがつくByeBuyで使用するパスワードは " + @item.pass.to_s + " です。
商品の情報編集・コメントの返信・取引終了手続きに必要なので大事に保存してください。
商品名:" + @item.name.to_s + "
↓商品詳細ページはコチラ↓
https://tsukubyebuy.herokuapp.com/items/" + @item.id.to_s + "
==========================
      つくByeBuy運営
  tsuku.byebuy@gmail.com
==========================
"
      respond_to do |format|
        flash[:notice] = "商品の出品が完了しました。"
        format.html { redirect_to @item}
        format.json { render :show, status: :created, location: @item }
      end
    else
      # トークンがない、もしくは２回目のアクセス -> 失敗を通知、ユーザ登録ページのリンクを貼る
      if token && token.item.activated
        redirect_to :root, alert: "その商品は本登録が完了しています。"
      else
        redirect_to :new, alert: "仮登録の有効期限が切れている。もしくは、URLが適切ではありません。"
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    password = params[:item][:confirm]
    if password == @item.pass || password == ENV['MASTER_PASS']

      respond_to do |format|
        if @item.update(item_params)
          format.html { redirect_to @item }
          format.json { render :show, status: :ok, location: @item }

          if @item.save
            if @item.student_id.to_s == "818129298"
              email = "tsuku.byebuy@gmail.com"
            else
              email = @item.student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
            end
            body = @item.student_id.to_s + "様

商品の編集が完了しました。

商品名:" + @item.name.to_s + "

↓商品詳細ページはコチラ↓
https://tsukubyebuy.herokuapp.com/items/" + @item.id.to_s + "

==========================
      つくByeBuy運営
  tsuku.byebuy@gmail.com
==========================
"
            ActionMailer::Base.mail(from: "sg5td9uo@idcf.kke.com", to: email, subject: "[つくByeBuy]商品の編集完了", body:body).deliver
          else
            format.html { render :edit }
            format.json { render json: @item.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      flash[:notice] = "※※※パスワードが間違っています。"
      redirect_to :action => "edit", :id => @item.id,:anchor => 'upd'
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    password = params[:password]
    if @item.pass == password || password == ENV['MASTER_PASS']
      if @item.student_id.to_s == "818129298"
        email = "tsuku.byebuy@gmail.com"
      else
        email = @item.student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
      end
      body = @item.student_id.to_s + "様

取引お疲れ様です。
つくByeBuyのご利用、ありがとうございました。

商品名:" + @item.name.to_s + "

==========================
      つくByeBuy運営
  tsuku.byebuy@gmail.com
==========================
"

      ActionMailer::Base.mail(from: "sg5td9uo@idcf.kke.com", to: email, subject: "[つくByeBuy]商品取引終了完了", body:body).deliver
      @item.sold = 8181
      @item.save
      redirect_to :action => "index"
    else
      flash[:pass_destroy] = "※※※パスワードが間違っています。"
      redirect_to :action => "show", :id => @item.id,:anchor => 'des'
    end
  end


  def done
    if params[:mail][:content].empty?
      flash[:error_m] = "空欄のまま出品者に連絡はできません。"
    end
    if params[:mail][:student_id].empty?
      flash[:error_n] = "学籍番号を入力してください。"
    end
    if params[:mail][:content].empty? || params[:mail][:student_id].empty?
      flash[:id] = params[:to_mail][:item_id]
      flash[:number] = params[:to_mail][:student_id]
      redirect_to '/mail_page/cancel'
    else
      from_mail = params[:mail][:student_id]
      if from_mail == "818129298"
        from_mail = "tsuku.byebuy@gmail.com"
      else
        from_mail = params[:mail][:student_id].to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
      end

      @item = Item.find(params[:to_mail][:item_id])

      if @item.student_id.to_s == "818129298"
        email = "tsuku.byebuy@gmail.com"
      else
        email = @item.student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
      end

      body = @item.student_id.to_s + "様

  " + params[:mail][:student_id].to_s + "さんから出品した商品に取引を希望する連絡が届きました。
  " + from_mail + "へ返信をして取引を始めてください。

  連絡内容:" + params[:mail][:content].to_s + "
https://tsukubyebuy.herokuapp.com/items/" + @item.id.to_s + "
  商品名:" + @item.name.to_s + "

  ==========================
        つくByeBuy運営
    tsuku.byebuy@gmail.com
  ==========================
  "

      ActionMailer::Base.mail(from: "sg5td9uo@idcf.kke.com", to: email, subject: "[つくByeBuy]閲覧者からの連絡", body:body).deliver
      redirect_to '/mail_page/done2'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :place_id, :image, :image_cache, :price, :detail, :genre_id, :student_id, :department_id)
    end
end
