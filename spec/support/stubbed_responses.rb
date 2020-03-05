module StubbedResponses
  BASE_URI = 'https://m2.vlc360.es:3000'
  API_URLS = {
    work: {
      save: '/api/customerPortalWebServices/work'
    }
  }

  def self.included(base)
    base.extend ClassMethods
  end

  def api_url(resource, method)
    "#{BASE_URI}#{API_URLS[resource][method]}"
  end

  def api_response(resource, method, variant)
    response = Hashie.symbolize_keys(
      YAML.load_file("#{File.dirname(__FILE__)}/stubbed_responses.yml")
    )[:responses][resource][method][variant]

    {
      status: response[:status] || 200,
      headers: {},
      body: response[:body].to_json
    }
  end

  module ClassMethods
    def stub_works_api(resource, method, variant)
      before :each do
        stub_request(:post, api_url(resource, method)).to_return(api_response(resource, method, variant))
      end
    end
  end
end
