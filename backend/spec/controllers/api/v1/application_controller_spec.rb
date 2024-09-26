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

    def render_form_error_test
      self.class.const_set(:SomeForm, Class.new do
        include ActiveModel::Model
        attr_accessor :some_attribute

        validates :some_attribute, presence: true
      end)

      form = SomeForm.new
      render_form_error(form) and return if form.invalid?

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

  describe '#render_form_error' do
    subject {
      get '/render_form_error_test'
      response
    }

    before(:each) do
      Rails.application.routes.draw do
        get '/render_form_error_test', to: 'tests#render_form_error_test'
      end
    end

    after(:each) { Rails.application.reload_routes! }

    it 'ステータスコード400が返ってくること' do
      expect(subject).to have_http_status(:bad_request)
    end
  end
end
