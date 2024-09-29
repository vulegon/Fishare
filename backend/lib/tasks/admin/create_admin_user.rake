
# nameは任意の引数で、デフォルト値は「管理者」
# example:
#  rake "admin:create[test_admin@gmail.com,password123]"
namespace :admin do
  desc "管理者ユーザーを作成する（引数: name, email, password）"
  task :create, [:email, :password, :name] => :environment do |task, args|
    name = args[:name]
    email = args[:email]
    password = args[:password]

    if email.blank? || password.blank?
      abort("引数に email と password を指定してください")
    end

    # メールアドレスの形式をチェック
    unless email.match?(URI::MailTo::EMAIL_REGEXP)
      abort("メールアドレスの形式が正しくありません: #{email}")
    end

    # パスワードの複雑さをチェック (アルファベットと数字の両方を含む)
    unless ::PasswordFormatValidator.valid_password?(password)
      abort("パスワードは8文字以上、128以下。また、パスワードには少なくとも1つのアルファベット大文字・小文字と1つの数字を含める必要があります")
    end

    if ::User.exists?(email: email)
      abort("既に同じメールアドレスのユーザーが存在します: #{email}")
    end

    if name.blank?
      name = "管理者"
    end

    ::Api::V1::Admin::UserService.create_admin_user!(email, password, name: name)

    puts "管理者ユーザーを作成しました: name: #{name} email: #{email}, password: #{password}"
  end
end
