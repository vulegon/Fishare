require 'rails_helper'

describe Api::V1::ApplicationController, type: :request do
  class TestsController < Api::V1::ApplicationController
    def test
      render status: :ok, json: {}
    end

    def error
      raise StandardError, 'システムエラー'

      render status: :ok, json: {}
    end
  end

  describe '#render_500' do
    subject {
      get '/test_error'
      response
    }

    before(:each) do
      Rails.application.routes.draw do
        get '/test_error', to: 'tests#error'
      end
    end

    after(:each) { Rails.application.reload_routes! }

    it 'ステータスコード500が返ってくること' do
      expect(subject).to have_http_status(:internal_server_error)
      expect(JSON.parse(subject.body)).to eq(
        'message' => 'システムエラーが発生しました。サポートにお問い合わせください',
        'errors' => 'システムエラー'
      )
    end
  end
end
