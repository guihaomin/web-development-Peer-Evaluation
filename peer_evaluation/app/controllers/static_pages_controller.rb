class StaticPagesController < ApplicationController
  def home
  end

  def register
    @user = User.new
  end

  def login
    @user = User.new
  end

  def users
    @users = User.all
  end

  def about
  end

  def contact
  end

end
