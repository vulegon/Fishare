module Api
  module V1
    module Concerns
      module Paginatable
        extend ActiveSupport::Concern

        included do
          include ActiveModel::Model
          include ActiveModel::Attributes
          include ActiveRecord::AttributeMethods::BeforeTypeCast

          attribute :limit, :integer, default: 30
          attribute :offset, :integer, default: 1

          validate :limit_must_be_integer
          validate :offset_must_be_integer
          validate :limit_must_be_greater_than_one
          validate :offset_must_be_greater_than_one
          validate :limit_must_be_less_than_equal_uplimit_limit
        end

        DEFAULT_LIMIT = 30
        DEFAULT_OFFSET = 1
        MIN_LIMIT = 1
        OFFSET_MIN_LIMIT = 1
        MAX_LIMIT = 1000

        private

        def limit_param
          @limit_param ||= limit_before_type_cast.nil? ? DEFAULT_LIMIT : convert_to_integer(limit_before_type_cast)
        end

        def offset_param
          @offset_param ||= offset_before_type_cast.nil? ? DEFAULT_OFFSET : convert_to_integer(offset_before_type_cast)
        end

        # ActiveModel::Attributesにintegerを指定するとシステム側でintegerに変換がかかってしまう。文字列の場合は0になってしまう。
        # そのため、integerに変換する前の値でIntegerに変換ができる値なのかをチェックする
        # @return [Integer, nil] 変換可能な場合はInteger、変換不可能な場合はnil
        def convert_to_integer(value)
          return nil if value.to_s.include?('.') # 小数点を含む場合は変換不可

          begin
            Integer(value)
          rescue ArgumentError, TypeError
            nil
          end
        end

        # 正常値の場合のみlimitを返します
        def limit_value
          @limit_value ||= limit_param if limit_param.present? && limit_param.is_a?(Integer)
        end

        # 正常値の場合のみoffsetを返します
        def offset_value
          @offset_value ||= offset_param if offset_param.present? && offset_param.is_a?(Integer)
        end

        # limitの上限値を超えているかどうか
        # @return [Boolean]
        def limit_exceeded?
          limit_value.present? && limit_value > MAX_LIMIT
        end

        def limit_must_be_integer
          return if limit_value.present? && limit_value.is_a?(Integer)

          errors.add(:limit, 'limitは整数で指定してください')
        end

        def offset_must_be_integer
          return if offset_value.present? && offset_value.is_a?(Integer)

          errors.add(:offset, 'offsetは整数で指定してください')
        end

        def limit_must_be_greater_than_one
          return if limit_value.blank?

          errors.add(:limit, "limitは#{MIN_LIMIT}以上の整数で指定してください") if limit_value.present? && limit_value < MIN_LIMIT
        end

        def offset_must_be_greater_than_one
          return if offset_value.blank?

          errors.add(:offset, "offsetは#{OFFSET_MIN_LIMIT}以上の整数で指定してください") if offset_value.present? && offset_value < OFFSET_MIN_LIMIT
        end

        def limit_must_be_less_than_equal_uplimit_limit
          return if limit_value.blank?

          errors.add(:limit, 'limitが上限を超えています') if limit_exceeded?
        end
      end
    end
  end
end
