module StubbedResponses
  BASE_URI = 'http://experiences.spain.info/experiences'
  API_URLS = {
    experience: {
      list: 'es_ES/getallporposals',
      search: 'es_ES/findporposalbytitle',
      find: 'es_ES/findporposalbyid',
      save: 'es_ES/create-update-porposal',
      translate: 'en_US/1/create-update-localizedporposal',
      validate: 'validate-porposal'
    },
    image: {
      save: 'upload-image'
    }
  }

  def self.included(base)
    base.extend ClassMethods
  end

  def api_url(resource, method)
    "#{BASE_URI}/json/#{API_URLS[resource][method]}"
  end

  def api_response(resource, method, variant)
    response = Hashie.symbolize_keys(
      YAML.load_file("#{File.dirname(__FILE__)}/stubbed_responses.yml")
    )[:responses][resource][method][variant]

    {
      status: 200,
      headers: {},
      body: response[:body].to_json
    }
  end

  module ClassMethods
    def stub_experiences_api(resource, method, variant)
      before :each do
        stub_request(:post, api_url(resource, method)).to_return(api_response(resource, method, variant))
      end
    end
  end
end
