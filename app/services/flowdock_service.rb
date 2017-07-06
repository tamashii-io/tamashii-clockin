# frozen_string_literal: true

require 'net/http'

class FlowdockService
  ENDPOINT = 'https://api.flowdock.com/flows'

  def initialize(token)
    @token = token
  end

  # TODO: Refactor below method
  # rubocop:disable Metrics/MethodLength
  def notify(channel, subject, content, status)
    post(
      messages_uri(channel),
      event: 'activity',
      title: content,
      external_thread_id: Time.zone.now.to_i,
      author: {
        # TODO: Replace by self-hosted avatar
        avatar: 'https://dxgv4vuja9avs.cloudfront.net/applications/1930/1f17702090f575d8.png',
        name: 'Tamashii Clockin'
      },
      thread: {
        title: subject,
        status: status
      }
    )
  end

  protected

  def messages_uri(channel)
    URI(ENDPOINT + '/' + channel + '/messages?flow_token=' + @token)
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
