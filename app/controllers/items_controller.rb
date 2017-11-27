class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show

    @item = Item.find(params[:id])
    @comments = @item.comments.all
    @comment = @item.comments.build

  end

  def comment
      @return = params[:choice_c] + params[:comment_body]
      @comment = Comment.new(comment_body: @return, item_id: params[:item_id])
      @comment.save
      redirect_to :action => "show", :id => @comment.item_id, :anchor => 'com'
      # if @comment.save
      #   @item = Item.find(params[:item_id])
      #   email = @item.student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
      #   body = @item.student_id.to_s + "様
      #
      #   出品した商品に新しくコメントが届きました。
      #   以下のリンクから返信フォームをご利用ください。
      #
      #   https://a2-autumn.herokuapp.com/items/" + @item.id.to_s + "
      #   商品名:" + @item.name.to_s + "
      #
      #
      #   このメールは筑波大学の講義「情報メディア実験B」での実習で作成されたものです。
      #   心当たりの無い場合は誤送ですので、無視していただければと思います。申し訳ありません。
      #
      #   ==================================
      #    enPiT2017 tsuku.byebuy@gmail.com
      #    チームA1 ムードメーカー  小島 直
      #   ==================================
      #   "
      #
      #   ActionMailer::Base.mail(from: "[つくByeBuy運営局]", to: email, subject: "[つくByeBuy]新着コメント", body:body).deliver
      # end
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
    num = ('0'..'9').to_a
    @item.pass = Array.new(4){num[rand(num.size)]}.join
    # if @item.save
    #   email = @item.student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
    #   body = @item.student_id.to_s + "様
    #
    #   出品が完了しました。
    #
    #   編集用パスワードは " + @item.pass.to_s + " です。
    #   商品の情報編集・販売完了・出品取り消し等に必要なので大事に保存してください。
    #
    #   商品名:" + @item.name.to_s + "
    #
    #   ↓商品詳細ページはコチラ↓
    #   https://a2-autumn.herokuapp.com/items/" + @item.id.to_s + "
    #
    #   このメールは筑波大学の講義「情報メディア実験B」での実習で作成されたものです。
    #   心当たりの無い場合は誤送ですので、無視していただければと思います。申し訳ありません。
    #
    #   ==================================
    #    enPiT2017 tsuku.byebuy@gmail.com
    #    チームA1 ムードメーカー  小島 直
    #   ==================================
    #   "
    #
    #   ActionMailer::Base.mail(from: "[つくByeBuy運営局]", to: email, subject: "[つくByeBuy]出品完了", body:body).deliver
    # end

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: '商品が登録されました。' }
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
    # if @item.save
    #   email = @item.student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
    #   body = @item.student_id.to_s + "様
    #
    #   商品の編集が完了しました。
    #
    #   商品名:" + @item.name.to_s + "
    #
    #   ↓商品詳細ページはコチラ↓
    #   https://a2-autumn.herokuapp.com/items/" + @item.id.to_s + "
    #
    #   このメールは筑波大学の講義「情報メディア実験B」での実習で作成されたものです。
    #   心当たりの無い場合は誤送ですので、無視していただければと思います。申し訳ありません。
    #
    #   ==================================
    #    enPiT2017 tsuku.byebuy@gmail.com
    #    チームA1 ムードメーカー  小島 直
    #   ==================================
    #   "
    #
    #   ActionMailer::Base.mail(from: "[つくByeBuy運営局]", to: email, subject: "[つくByeBuy]商品の編集完了", body:body).deliver
    # end
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    # email = @item.student_id.to_s.gsub(/^20/, "s") + "@u.tsukuba.ac.jp"
    # body = @item.student_id.to_s + "様
    #
    # 出品の取り消しが完了しました。
    #
    # 商品名:" + @item.name.to_s + "
    #
    # このメールは筑波大学の講義「情報メディア実験B」での実習で作成されたものです。
    # 心当たりの無い場合は誤送ですので、無視していただければと思います。申し訳ありません。
    #
    # ==================================
    #  enPiT2017 tsuku.byebuy@gmail.com
    #  チームA1 ムードメーカー  小島 直
    # ==================================
    # "
    #
    # ActionMailer::Base.mail(from: "[つくByeBuy運営局]", to: email, subject: "[つくByeBuy]出品の取り消し完了", body:body).deliver
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
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
