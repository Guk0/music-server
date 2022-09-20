require 'swagger_helper'

RSpec.describe 'playlist_tracks', type: :request do
  path '/playlist_tracks' do
    get 'get playlist_tracks' do
      tags 'playlist_track'
      parameter name: :Authorization, in: :header, type: :integer, description: '사용자 인증(user_id 입력)', required: true
      parameter name: :playlist_id, in: :query, type: :integer, description: 'playlist', required: true
      parameter name: :page, in: :query, type: :string, description: 'page', example: 1, required: false
      description 'playlist_track list를 조회합니다. <br> playlist에 속한 playlist_track만 조회합니다. <br> default(플레이리스트) 타입 조회시 사용자 인증을 요구합니다. <br> my_album(내 앨범) 타입은 요구하지 않습니다. '

      before do
        @playlist = FactoryBot.create(:playlist)
        @user = @playlist.owner
      end
      
      response 200, 'get playlist_tracks' do
        let(:Authorization) { @user.id }
        let(:playlist_id) { @playlist.id }

        run_test!
      end
    end


    post 'create playlist_track' do
      tags 'playlist_track'
      parameter name: :Authorization, in: :header, type: :integer, description: '사용자 인증(user_id 입력)', required: true
      # parameter name: :playlist_id, in: :query, type: :integer, description: '사용자가 playlist에 대한 권한이 있나 확인', required: true
      parameter name: :playlist_track, in: :body, schema: { '$ref' => '#/components/schemas/playlist_track_object' }      
      description 'playlist_track를 생성합니다. <br> body의 user_id는 playlist_track을 생성한 사람입니다. <br> 사용자 검증을 위하여 user_id와 playlist_id를 추가로 받습니다.'

      before do
        @playlist = FactoryBot.create(:playlist)
        @user = @playlist.owner
        @track = FactoryBot.create(:track)
      end
      
      response 201, 'create playlist_track' do
        let(:playlist_track) { { playlist_id: @playlist.id, user_id: @user.id, track_id: @track.id } }
        let(:Authorization) { @user.id }
        # let(:playlist_id) { @playlist.id }

        run_test!
      end
    end
  end

  path '/playlist_tracks/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    before do
      @playlist = FactoryBot.create(:playlist)
      @track = FactoryBot.create(:track)
      @user = @playlist.owner
      @playlist_track = FactoryBot.create(:playlist_track, playlist: @playlist, track: @track, user: @user)
    end

    delete 'delete playlist_track' do
      tags 'playlist_track'
      parameter name: :Authorization, in: :header, type: :integer, description: '사용자 인증(user_id 입력)', required: true
      parameter name: :playlist_id, in: :query, type: :integer, description: '사용자가 playlist에 대한 권한이 있나 확인', required: true
      description 'playlist_track을 삭제합니다.'

      response(204, 'successful') do
        let(:id) { @playlist_track.id }
        let(:Authorization) { @user.id }
        let(:playlist_id) { @playlist.id }

        run_test!
      end
    end
  end
end
