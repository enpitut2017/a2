class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.order('created_at DESC').all
  end

  # GET /items/1
  # GET /items/1.json
  def show

    @item = Item.find(params[:id])
    @comments = @item.comments.all
    @comment = @item.comments.build

  end

  def comment
      @item = Item.find(params[:item_id])
      password = params[:password]
      judge = "3"

      if password == @item.pass then
        judge = "1"
      elsif password == "" then
        judge = "0"
      else
        judge = "2"
        flash[:notice] = "※※※パスワードが間違っています。"
        redirect_to action:  "show", id: params[:item_id]


      end


      if judge == "1"  || judge == "0" then
      @comment = Comment.new(comment_body: params[:comment_body], item_id: params[:item_id],reply: params[:choice_c],judge: judge)
      @comment.save


      redirect_to :action => "show", :id => @comment.item_id
      if @comment.save
        if @comment.judge == "0"
        @item = Item.find(params[:item_id])
        email = @item.student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
        body = @item.student_id.to_s + "様

        出品した商品に新しくコメントが届きました。
        以下のリンクから返信フォームをご利用ください。

        https://a2-autumn.herokuapp.com/items/" + @item.id.to_s + "
        商品名:" + @item.name.to_s + "
        コメント内容:" + @comment.comment_body.to_s + "

        このメールは筑波大学の講義「情報メディア実験B」での実習で作成されたものです。
        心当たりの無い場合は誤送ですので、無視していただければと思います。申し訳ありません。

        ==================================
         enPiT2017 tsuku.byebuy@gmail.com
         チームA1 ムードメーカー  小島 直
        ==================================
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
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    items = Item
    pass_check = "0"
    id_i = 1
        while id_i <= Item.last.id do
      @it = Item.find(id_i)
      if @it.student_id == @item.student_id
        @item.pass = @it.pass
        pass_check = "1"
      end
      id_i += 1
    end
    if pass_check == "0"
      num = ('0'..'9').to_a
      @item.pass = Array.new(4){num[rand(num.size)]}.join
    end
    if @item.save
      email = @item.student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
      body = @item.student_id.to_s + "様

      出品が完了しました。

      編集用パスワードは " + @item.pass.to_s + " です。
      商品の情報編集・販売完了・出品取り消し等に必要なので大事に保存してください。

      商品名:" + @item.name.to_s + "

      ↓商品詳細ページはコチラ↓
      https://a2-autumn.herokuapp.com/items/" + @item.id.to_s + "

      このメールは筑波大学の講義「情報メディア実験B」での実習で作成されたものです。
      心当たりの無い場合は誤送ですので、無視していただければと思います。申し訳ありません。

      ==================================
       enPiT2017 tsuku.byebuy@gmail.com
       チームA1 ムードメーカー  小島 直
      ==================================
      "

      ActionMailer::Base.mail(from: "sg5td9uo@idcf.kke.com", to: email, subject: "[つくByeBuy]出品完了", body:body).deliver
    end

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item}
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
password = params[:item][:confirm]
if password == @item.pass

    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item }
        format.json { render :show, status: :ok, location: @item }

        if @item.save
          email = @item.student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
          body = @item.student_id.to_s + "様

          商品の編集が完了しました。

          商品名:" + @item.name.to_s + "

          ↓商品詳細ページはコチラ↓
          https://a2-autumn.herokuapp.com/items/" + @item.id.to_s + "

          このメールは筑波大学の講義「情報メディア実験B」での実習で作成されたものです。
          心当たりの無い場合は誤送ですので、無視していただければと思います。申し訳ありません。

          ==================================
           enPiT2017 tsuku.byebuy@gmail.com
           チームA1 ムードメーカー  小島 直
          ==================================
          "

          ActionMailer::Base.mail(from: "sg5td9uo@idcf.kke.com", to: email, subject: "[つくByeBuy]商品の編集完了", body:body).deliver
        end

      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end

else
       redirect_to :action => "edit", :id => @item.id
end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    email = @item.student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
    body = @item.student_id.to_s + "様

    出品の取り消しが完了しました。

    商品名:" + @item.name.to_s + "

    このメールは筑波大学の講義「情報メディア実験B」での実習で作成されたものです。
    心当たりの無い場合は誤送ですので、無視していただければと思います。申し訳ありません。

    ==================================
     enPiT2017 tsuku.byebuy@gmail.com
     チームA1 ムードメーカー  小島 直
    ==================================
    "

    ActionMailer::Base.mail(from: "sg5td9uo@idcf.kke.com", to: email, subject: "[つくByeBuy]出品の取り消し完了", body:body).deliver
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :place_id, :image, :price, :detail, :genre_id, :student_id, :department_id)
    end
end
