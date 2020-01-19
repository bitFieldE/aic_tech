class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :login_required, except: [:new, :create, :show]
  before_action :gender_reflector, only: [:show]
  before_action :logined_check, only: [:new]

  # GET /users
  # GET /users.json
  def index
    @users = User.fetch_users(current_user).order(created_at: :asc)
      .page(params[:page]).per(10)
  end

  # index
  def search
    @users = User.fetch_users(current_user).search(params[:q])
      .page(params[:page]).per(10)
    render "index"
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @blogs = set_user.blogs.readable_for(current_user)
      .order(posted_at: :desc).page(params[:page]).per(5)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to :account, notice: '会員を登録しました。' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to :account, notice: '会員を更新しました' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'プロフィールを削除しました' }
      format.json { head :no_content }
    end
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def gender_reflector
      @user = set_user
      if current_user && current_user.administrator == false
        redirect_to :account if current_user.gender == @user.gender
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      attrs = [
        :new_profile_picture,
        :remove_profile_picture,
        :name,
        :email,
        :birthday,
        :gender,
        :area,
        :occupation,
        :introduction,
        :voice,
        :administrator
      ]
      attrs << :password if params[:action] == "create"
      params.require(:user).permit(attrs)
    end
end
