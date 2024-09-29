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
    unless password.match?(/^(?=.*[a-zA-Z])(?=.*[0-9])/)
      abort("パスワードには少なくとも1つのアルファベットと1つの数字を含める必要があります")
    end

    if name.blank?
      name = "管理者"
    end

    ::Api::V1::Admin::CreateService.create_admin_user!(email, password, name: name)

    puts "管理者ユーザーを作成しました: name: #{name} email: #{email}, password: #{password}"
  end
end
