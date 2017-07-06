# frozen_string_literal: true

require 'net/http'

class SlackService
  ENDPOINT = 'https://hooks.slack.com/services'

  def initialize(token)
    @token = token
  end

  # TODO: Refactor below method
  # rubocop:disable Metrics/MethodLength
  def notify(subject, status, content)
    post(
      messages_uri,
      'text': subject,
      'attachments': [
        {
          'title': status,
          'fields': content,
          'author_name': 'Tamashii-chockin',
          'author_icon': 'https://cdn0.iconfinder.com/data/icons/long-shadow-web-icons/512/ruby-512.png'
        }
      ]
    )
  end

  protected

  def messages_uri
    URI(ENDPOINT + '/' + @token)
  end

  def post(uri, data)
    req = Net::HTTP::Post.new(uri)
    req.content_type = 'application/json'
    req.body = data.to_json
    http(uri) { |http| http.request(req) }
  end

  def http(uri, &block)
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, &block)
  end
end
