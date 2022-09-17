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
  
    def self.search_by_dsl query, artist_id, album_id, sort
      query = {
        query: {                
          bool: {
            must: [
              { 
                multi_match: {
                  query: query,
                  operator: "and",
                  fields: ["title", "album_name", "artist_name"],
                }
              },
            ]   
          },
        }
      }    
      query[:query][:bool][:must].append({ match: { artist_id: artist_id } }) if artist_id.present?
      query[:query][:bool][:must].append({ match: { album_id: album_id } }) if album_id.present?
      query[:sort] = [{ sort.to_sym => "desc" }] if sort.present?
      self.__elasticsearch__.search(query).records.records
    end
  end
end
