require 'swagger_helper'

RSpec.describe 'albums', type: :request do
  path '/albums' do
    get('list albums') do
      parameter name: 'page', in: :path, type: :string, description: 'page', required: false
      description 'album 리스트를 가져옵니다.'
      
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

    post('create album') do
      parameter name: :album, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          artist_id: { type: :bigint }
        },
        required: [ 'title', 'artist_id' ]
      }
      description '앨범을 생성합니다. artist_id와 title은 필수입니다.'
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
  end

  path '/albums/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show album') do
      description '개별 album을 조회합니다. artist와 track list를 포함합니다.'
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

    patch('update album') do      
      parameter name: :album, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          artist_id: { type: :bigint }
        },
        required: [ 'title', 'artist_id' ]
      }

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

    put('update album') do
      parameter name: :album, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          artist_id: { type: :bigint }
        },
        required: [ 'title', 'artist_id' ]
      }

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

    delete('delete album') do
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
