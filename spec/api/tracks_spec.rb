require 'swagger_helper'

RSpec.describe 'tracks', type: :request do
  path '/tracks' do
    get 'list tracks' do
      tags 'track'

      parameter name: 'q', in: :query, type: :string, description: 'search by title or artist_name or album_name', example: "아이유", required: false
      parameter name: 'artist_id', in: :query, type: :string, description: 'search by artist_id', example: 1, required: false
      parameter name: 'album_id', in: :query, type: :string, description: 'search by album_id', example: 1, required: false
      parameter name: 'sort', in: :query, type: :string, description: 'sort by created_at or likes_count', example: "likes_count", required: false
      parameter name: 'page', in: :query, type: :string, description: 'page', example: 1, required: false
      description 'track 리스트를 가져옵니다. <br> q(title, artist_name, album_name), artist_id, album_id, sort, page를 params로 받아 필터링합니다.'
      
      response(200, 'successful') do
        run_test!
      end
    end

    post 'create track' do
      tags 'track'
      parameter name: :track, in: :body, schema: { '$ref' => '#/components/schemas/track_object' }
      description 'track를 생성합니다.'

      before do
        @album = FactoryBot.create(:album)
        @artist = @album.artist
      end
  
      response 201, 'track created' do
        let(:track) { { title: 'track name', artist_id: @artist.id, album_id: @album.id } }
        run_test!
      end
    end
  end

  path '/tracks/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    before do
      @track = FactoryBot.create(:track)
      @album = @track.album
      @artist = @track.artist
    end

    get 'show track' do
      tags 'track'
      description '개별 track을 조회합니다.'


      response(200, 'successful') do
        let(:id) { @track.id }

        run_test!
      end
    end

    put 'update track' do
      tags 'track'
      parameter name: :track, in: :body, schema: { '$ref' => '#/components/schemas/track_object' }

      response(200, 'successful') do
        let(:id) { @track.id }
        let(:track) { { title: 'new track name', artist_id: @artist.id, album_id: @album.id } }

        run_test!
      end
    end

    delete 'delete track' do
      tags 'track'
      response(204, 'successful') do
        let(:id) { @track.id }

        run_test!
      end
    end
  end
end
