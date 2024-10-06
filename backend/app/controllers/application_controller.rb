class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Cookies

  def authenticate_user!
    unless cookies_access_token && cookies_uid && cookies_client
      render json: { message: '認証情報が不足しています' }, status: :unauthorized and return
    end

    unless current_user
      render json: { message: 'ユーザーが見つかりません' }, status: :not_found and return
    end
  end

  def current_user
    @current_user ||= begin
      access_token = cookies_access_token
      uid = cookies_uid
      client = cookies_client

      return nil if access_token.blank? || uid.blank? || client.blank?

      User.find_by_auth_token(access_token, client, uid)
    end
  end

  private

  def cookies_access_token
    @cookies_access_token ||= cookies[:access_token]
  end

  def cookies_uid
    @cookies_uid ||= cookies[:uid]
  end

  def cookies_client
    @cookies_client ||= cookies[:client]
  end
end
