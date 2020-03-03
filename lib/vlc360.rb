require 'httparty'

require 'facets/kernel/deep_clone'
require 'facets/hash/deep_rekey'

unless defined?(Rails)
  require 'facets/string/camelcase'
  require 'facets/string/snakecase'
end

require 'vlc360/client'

require 'vlc360/api_operations/list'
require 'vlc360/api_operations/find'
require 'vlc360/api_operations/search'
require 'vlc360/api_operations/save'
require 'vlc360/api_operations/translate'
require 'vlc360/api_operations/validate'

require 'vlc360/resource'
require 'vlc360/api_resource'

require 'vlc360/session'
require 'vlc360/work'
require 'vlc360/injured'

# Version
require 'vlc360/version'

module VLC360
  @base_uri = 'https://m2.vlc360.es:3000'
  @company_id = ''
  @api_key = ''
  @token_session = ''

  class << self
    attr_accessor :token_session, :api_key, :company_id, :base_uri

    def client
      @client ||= VLC360::Client.new
    end
  end
end
