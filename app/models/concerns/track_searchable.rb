module TrackSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    
    mappings dynamic: 'false' do
      indexes :title
      indexes :album_id, type: :long
      indexes :artist_id, type: :long
      indexes :album_name
      indexes :artist_name
      indexes :likes_count, type: :long
      indexes :created_at, type: :date
    end  

    def self.search_by_dsl params
      track_query = TrackQuery.new(params)
      query = track_query.get_query()
 
      self.__elasticsearch__.search(query).page(params[:page]).records
    end
  
  end
end
