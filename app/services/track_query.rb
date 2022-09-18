class TrackQuery
  attr_reader :q, :artist_id, :album_id, :sort, :query

  def initialize params
    @q = params[:q]
    @artist_id = params[:artist_id]
    @album_id = params[:album_id]
    @sort = params[:sort]
    @query = {
      query: {                
        bool: {
          must: []   
        },
      }
    }
  end

  def get_query
    set_match_string if q.present?
    set_match_artist_id if artist_id.present?
    set_match_album_id if album_id.present?
    
    @query = {} if query[:query][:bool][:must].length.zero?

    set_sort if sort.present?
    query
  end

  private
  def set_match_string
    query[:query][:bool][:must].append(
      { 
        multi_match: {
          query: q,
          operator: "and",
          fields: ["title", "album_name", "artist_name"],
        } 
      }
    )
  end

  def set_match_artist_id    
    query[:query][:bool][:must].append({ match: { artist_id: artist_id } })
  end

  def set_match_album_id
    query[:query][:bool][:must].append({ match: { album_id: album_id } })
  end

  def set_sort
    query[:sort] = [{ sort.to_sym => "desc" }]
  end
end