require 'rails_helper'

RSpec.describe Api::V1::Concerns::Paginatable do
  before do
    stub_const('PaginatableParameter', Class.new do
      include ::Api::V1::Concerns::Paginatable

      def initialize(params)
        super(params.permit(self.class.attribute_names))
      end
    end)
  end

  describe '#valid?' do
    subject { PaginatableParameter.new(ActionController::Parameters.new(params)).valid? }

    context 'パラメータが有効の場合' do
      context 'パラメータが指定されていない場合' do
        let(:params) { {} }

        it { is_expected.to be true }
      end

      context 'パラメータが指定されている場合' do
        context 'offsetとlimitがintegerで指定されている場合' do
          let(:params) { { offset: 1, limit: 20 } }

          it { is_expected.to be true }
        end

        context 'offsetとlimitがintegerに変換できる文字列が指定されている場合' do
          let(:params) { { offset: '1', limit: '20' } }

          it { is_expected.to be true }
        end
      end
    end

    context 'パラメータが無効の場合' do
      context 'offsetが整数ではないとき' do
        context 'offsetが文字列の場合' do
          let(:params) { { offset: 'あいうえお' } }

          it { is_expected.to be false }
        end

        context 'offsetが小数点を含む値の場合' do
          let(:params) { { offset: 1.1 } }

          it { is_expected.to be false }
        end
      end

      context 'offsetが最小値である1未満の時' do
        let(:params) { { offset: 0 } }

        it { is_expected.to be false }
      end

      context 'limitが整数ではないとき' do
        context 'limitが文字列の場合' do
          let(:params) { { limit: 'あいうえお' } }

          it { is_expected.to be false }
        end

        context 'limitが小数点を含む値の場合' do
          let(:params) { { limit: 1.1 } }

          it { is_expected.to be false }
        end
      end

      context 'limitが最小値である1未満の時' do
        let(:params) { { limit: 0 } }

        it { is_expected.to be false }
      end

      context 'limitが1000を超える時' do
        let(:params) { { limit: 1001 } }

        it { is_expected.to be false }
      end
    end
  end

  describe '#limit' do
    subject { PaginatableParameter.new(action_params).limit }

    let(:action_params) { ActionController::Parameters.new(params) }

    context 'limitが指定されていない場合' do
      let(:params) { {} }

      it 'デフォルト値が返ること' do
        expect(subject).to eq 30
      end
    end

    context 'limitが指定されている場合' do
      context '文字列で指定された場合' do
        let(:params) { { limit: '20' } }

        it '指定された値が返ること' do
          expect(subject).to eq 20
        end
      end

      context '整数で指定された場合' do
        let(:params) { { limit: 20 } }

        it '指定された値が返ること' do
          expect(subject).to eq 20
        end
      end
    end
  end

  describe '#offset' do
    subject { PaginatableParameter.new(action_params).offset }

    let(:action_params) { ActionController::Parameters.new(params) }

    context 'offsetが指定されていない場合' do
      let(:params) { {} }

      it 'デフォルト値が返ること' do
        expect(subject).to eq 1
      end
    end

    context 'offsetが指定されている場合' do
      context '文字列で指定された場合' do
        let(:params) { { offset: '20' } }

        it '指定された値が返ること' do
          expect(subject).to eq 20
        end
      end

      context '整数で指定された場合' do
        let(:params) { { offset: 20 } }

        it '指定された値が返ること' do
          expect(subject).to eq 20
        end
      end
    end
  end
end
