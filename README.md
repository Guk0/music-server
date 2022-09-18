# README

## 환경 세팅
- docker-compose 기반 프로젝트입니다. docker-compose up 명령어로 실행해주세요.
- env.docker.example 에서 .example만 지우고 사용하시면 됩니다.
- 실행 후 elasticsearch container에 문제 발생시 docker-compose down 한 뒤 재실행 해주세요.

<br>

## ERD
<img src="./public/image/erd.png"/>

- User (사용자)
- UserGroup (그룹 참여 사용자)
  - uniqueness on user_id and group_id
- Group (그룹)
- Playlist (재생목록, 내앨범)
  - owner(user, group) : polymorphic association 
  - type : default(재생목록), my_album(내 앨범)
- PlaylistTrack (재생목록에 추가된 음원)
- Track (음원)
- Album (앨범)
- Artist (가수)

<br>

## 시나리오
- User (사용자)
  - 사용자 생성 시 default 타입(재생목록)의 playlist를 생성합니다.
- Group (그룹)
  - group 생성 시 default 타입(재생목록)의 playlist를 생성합니다.
  - group을 생성한 사용자가 group의 owner가 됩니다.
  - group의 owner만 group을 생성하고 삭제할 수 있습니다. authenticate_user로 체크합니다.
- UserGroup (그룹 참여 사용자)
  - group의 owner만 group에 사용자를 추가, 삭제할 수 있습니다.
  - group에 동일한 사용자가 중복하여 참여할 수 없습니다.
- Playlist (재생목록, 내앨범(추가사항))
  - owner(user, group) : polymorphic association 
  - user와 group 생성시 자동으로 default type의 playlist가 생성되므로 my_album type의 playlist만 추가로 생성, 수정, 삭제할 수 있습니다.
  - my_playlist 액션을 통해 본인 혹은 본인이 속한 그룹의 playlist를 가져올 수 있습니다.
  - index와 show 액션을 통해 다른 사람 혹은 그룹의 my_album을 확인할 수 있습니다. 
- PlaylistTrack (재생목록에 추가된 음원)
  - 재생목록에는 100개의 음원만 추가할 수 있고 100개가 넘어갈시 가장 오래된 음원부터 삭제합니다.
  - playlist의 owner(user, group)에 속하는 user만 생성, 삭제할 수 있습니다. authenticate_user로 체크합니다.
  - user_id를 통해 추가한 사용자를 알 수 있습니다.
  - 곡의 중복이 가능합니다.
- Track (음원)
  - track의 필터링을 위해 elasticsearch를 사용하였습니다.
  - track에 대한 필터링은 title, artist_name, album_name, artist_id, album_id로 가능합니다.
  - track에 대한 정렬은 created_at, likes_count로 가능합니다.
- Album (앨범)
  - title 변경 시 album에 속한 track들의 album_name이 변경됩니다.
- Artist (가수)
  - name 변경 시 artist에 속한 track들의 artist_name이 변경됩니다.

<br>


## Endpoints
### users
- GET /users 
- GET /users/:id

### groups
- GET /groups
- GET /groups/:id  
- POST /groups
  - body format : {"group": {"name": xxx}, "user_id": xxx }
- PUT, PATCH /groups/:id
  - body format : {"group": {"name": xxx}, "user_id": xxx }
- DELETE /groups/:id
  - required params : user_id
  - create, update, destroy action은 user_id를 params로 받습니다. 
    - 인증 기능이 추가되면 받지 않도록 변경합니다.
    - authenticate_user로 사용자가 group의 owner인지 확인합니다. owner가 아니라면 Forbidden exception을 발생시킵니다.

### user_groups
- POST /user_groups
  - required params : group_id, owner_id, user_id
     - 그룹에 사용자를 추가합니다. owner만 사용자를 추가할 수 있어 owner_id를 받습니다.
     - authenticate_user로 owner인지 확인힙니다.
- DELETE /user_groups/:id
  - required params : group_id, owner_id
    - owner만 사용자를 삭제할 수 있습니다.

### playlists
- GET /playlists
  - 소유자 구분 상관없이 my_album(내앨범) 타입의 playlist를 조회합니다.
- GET /playlists:id
  - 소유자 구분 상관없이 my_album(내앨범) 타입의 playlist를 조회합니다.
- GET /playlists/my_playlist
  - 본인 혹은 그룹의 재생목록, 내 앨범을 조회힙니다.
  - required params : owner_id, owner_type
    - polymorphic association 이므로 owner_id와 owner_type을 받습니다.
    - owner_type은 일단 "user"와 "group"만 허용합니다.
- POST /playlists
  - my_album(내앨범) 타입의 playlist를 생성합니다.
  - required body : email, name
  - body format : {"playlist": {title: "xxx"}, "owner_type": "user", "owner_id": "1"}
- PUT, PATCH /playlists/:id
  - my_album(내앨범) 타입의 playlist를 수정합니다.
  - required params : group_id, owner_id
    - owner만 사용자를 삭제할 수 있습니다.
  - body format : {"playlist": {title: "xxx"}, "owner_type": "user", "owner_id": "1"}
- DELETE /playlists/:id
  - my_album(내앨범) 타입의 playlist를 삭제합니다.
  - required params : group_id, owner_id
    - owner만 사용자를 삭제할 수 있습니다.

### playlist_tracks
- POST /playlist_tracks
  - body format : {"playlist_tracks": {playlist_id: "2", "track_id": "1", "user_id": "1"}}
    - playlist에 track을 추가합니다.
    - authenticate_user로 owner에 속하는 유저인지 확인힙니다.
- DELETE /playlist_tracks/:id


### tracks
- GET /tracks
  - elasticsearch에서 track을 필터링합니다.
  - q, artist_id, album_id, sort, page를 params로 받습니다.
  - sort에는 likes_count, created_at를 사용할 수 있습니다.
- GET /tracks:id
- POST /tracks
- PUT, PATCH /tracks/:id
- DELETE /tracks/:id

