# example:
#  rake "users:update_password[uuid,Password123]"
namespace :users do
  desc "ユーザーのパスワードを変更する（引数: user_id, password）"
  task :update_password, [:user_id, :password] => :environment do |task, args|
    user = User.find(args[:user_id])
    password = args[:password]

    if password.blank?
      abort("引数に password を指定してください")
    end

    unless ::PasswordFormatValidator.valid_password_format?(password)
      abort("パスワードは8文字以上、128以下。また、パスワードには少なくとも1つのアルファベット大文字・小文字と1つの数字を含める必要があります")
    end

    ActiveRecord::Base.transaction do
      user.reset_password(password, password)
    end

    puts "管理者ユーザーを作成しました: name: #{name} email: #{email}, password: #{password}"
  end
end
