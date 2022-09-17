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
  
    def self.search_by_dsl q, artist_id, album_id, sort, page
      search = {
        query: {                
          bool: {
            must: []   
          },
        }
      }
      
      search[:query][:bool][:must].append(
        { 
          multi_match: {
            query: q,
            operator: "and",
            fields: ["title", "album_name", "artist_name"],
          } 
        }
      ) if q.present?
      search[:query][:bool][:must].append({ match: { artist_id: artist_id } }) if artist_id.present?
      search[:query][:bool][:must].append({ match: { album_id: album_id } }) if album_id.present?
      search[:sort] = [{ sort.to_sym => "desc" }] if sort.present?
      
      search = {} if q.blank? && artist_id.blank? && album_id.blank?

      self.__elasticsearch__.search(search).page(page).records
    end
  end
end
