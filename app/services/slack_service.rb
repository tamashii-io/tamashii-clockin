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
          'fields': [
            {
              'title': '已打卡人數',
              'value': content[:clockin],
              'short': true
            },
            {
              'title': '未打卡人數',
              'value': content[:not_clockin],
              'short': true
            }
          ],
          'author_name': 'chockin',
          'author_icon': 'http://a.slack-edge.com/7f18/img/api/homepage_custom_integrations-2x.png'
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
