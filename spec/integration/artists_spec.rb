require 'swagger_helper'

RSpec.describe 'artists', type: :request do
  path '/artists' do
    get 'list artists' do
      tags 'Artist'
      parameter name: 'page', in: :query, type: :string, description: 'page', example: 1, required: false
      description 'artist 리스트를 가져옵니다.'
      
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post 'create artist' do
      tags 'Artist'
      parameter name: :artist, in: :body, schema: { '$ref' => '#/components/schemas/artist_object' }

      description 'artist를 생성합니다. name은 필수입니다.'
      response 200, 'artist created' do
        let(:artist) { { name: 'artist name' } }
        run_test!
      end

      response 422, 'failed' do
        let(:artist) { { name: '' } }
        run_test!
      end
    end
  end

  path '/artists/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get 'show artist' do
      tags 'Artist'
      description '개별 artist을 조회합니다.'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put 'update artist' do
      tags 'Artist'
      parameter name: :artist, in: :body, schema: { '$ref' => '#/components/schemas/artist_object' }

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete 'delete artist' do
      tags 'Artist'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
