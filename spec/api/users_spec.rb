require 'swagger_helper'

RSpec.describe 'users', type: :request do
  path '/users' do    
    get 'list users' do      
      tags 'user'
      parameter name: 'page', in: :query, type: :string, description: 'page', example: 1, required: false
      description 'user 리스트를 가져옵니다.'
      
      response(200, 'successful') do
        run_test!
      end
    end
  end

  path '/users/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    before do
      @user = FactoryBot.create(:user)
    end

    get 'show user' do
      tags 'user'
      description '개별 user을 조회합니다. my_album 타입의 playlist를 포함합니다.'

      response(200, 'successful') do
        let(:id) { @user.id }
        run_test!
      end
    end
  end
end
