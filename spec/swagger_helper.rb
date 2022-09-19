# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      swagger: '2.0',
      info: {
        title: 'music API',
        version: 'v1'
      },
      consumes: ['application/json'],
      produces: ['application/json'],
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000',
          variables: {
            defaultHost: {
              default: 'http://localhost:3000'
            }
          }
        }
      ],
      components: {
        schemas: {
          album_object: {
            type: :object,
            properties: {
              album: {
                type: :object,
                properties: {
                  title: { type: :string, example: "growing up" },
                  artist_id: { type: :integer, example: 1 }            
                }
              }
            },
            required: [ 'title', 'artist_id' ]    
          },
          artist_object: {
            type: :object,
            properties: {
              artist: {
                type: :object,
                properties: {
                  name: { type: :string, example: "아이유" },
                }
              }
            },
            required: [ 'name' ]
          },
          group_object: {
            type: :object,
            properties: {
              group: {
                type: :object,
                properties: {
                  name: { type: :string, example: "그룹1" },
                }
              }
            },
            required: [ 'name' ]
          },
          playlist_object: {
            type: :object,
            properties: {
              playlist: {
                type: :object,
                properties: {
                  title: { type: :string, example: "내 앨범1" },
                }
              }
            },
            required: [ 'title' ]
          },
          playlist_track_object: {
            type: :object,
            properties: {
              playlist_track: {
                type: :object,
                properties: {
                  playlist_id: { type: :integer, example: 1 },
                  track_id: { type: :integer, example: 1 },
                  user_id: { type: :integer, example: 1 },
                }
              }
            },
            required: [ 'title' ]
          },
          track_object: {
            type: :object,
            properties: {
              track: {
                type: :object,
                properties: {
                  title: { type: :string, example: "안녕(Hello)" },
                  artist_id: { type: :integer, example: 1 },
                  album_id: { type: :integer, example: 1 },
                }
              }
            },
            required: [ 'title' ]
          },

        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
