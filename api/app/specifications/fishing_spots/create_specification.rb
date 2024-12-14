module FishingSpots
  class CreateSpecification
    # 釣り場を作成可能か判定
    # @param user [::User] 作成するユーザー
    # @return [Boolean] 作成できるかどうか
    def satisfied_by?(user)
      user.admin?
    end

    # 仕様を満たさなかったことを示すメッセージ
    # @return [String]
    def unsatisfied_reason
      '管理者以外は釣り場を作成できません'
    end
  end
end
