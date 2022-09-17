config = {
  host: ENV['ELASTICSEARCH_HOST']
}


Elasticsearch::Model.client = Elasticsearch::Client.new(config)
