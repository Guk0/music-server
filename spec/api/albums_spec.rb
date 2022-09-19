require 'swagger_helper'

RSpec.describe 'albums', type: :request do
  path '/albums' do    
    get 'list albums' do      
      tags 'Album'
      parameter name: 'page', in: :query, type: :string, description: 'page', example: 1, required: false
      description 'album 리스트를 가져옵니다.'
      
      response(200, 'successful') do
        run_test!
      end
    end

    post 'create album' do
      tags 'Album'
      parameter name: :album, in: :body, schema: { '$ref' => '#/components/schemas/album_object' }
  
      description '앨범을 생성합니다. artist_id와 title은 필수입니다.'

      before do
        @artist = FactoryBot.create(:artist)
      end

      response 200, 'album created' do
        let(:album) { { title: 'album title', artist_id: @artist.id } }
        run_test!
      end
    end
  end

  path '/albums/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    before do
      @album = FactoryBot.create(:album)
      @artist = FactoryBot.create(:artist)
    end

    get 'show album' do
      tags 'Album'
      description '개별 album을 조회합니다. artist와 track list를 포함합니다.'

      response(200, 'successful') do
        let(:id) { @album.id }
        run_test!
      end
    end

    put 'update album' do
      tags 'Album'
      parameter name: :album, in: :body, schema: { '$ref' => '#/components/schemas/album_object' }

      response(200, 'successful') do
        let(:id) { @album.id }
        let(:album) { { title: 'album title', artist_id: @artist.id } }

        run_test!
      end
    end

    delete 'delete album' do
      tags 'Album'

      response(204, 'successful') do
        let(:id) { @album.id }

        run_test!
      end
    end
  end
end
