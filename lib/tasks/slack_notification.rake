# frozen_string_literal: true

namespace :notification do
  NOTIFY_SUBJECT = 'Tamashii 打卡貼心提示'

  task clockin: :environment do
    slack = SlackService.new(Settings.slack.token)
    counts = CheckRecord.today.clockin.distinct(:user_id).count
    not_clockin_count = User.count - counts
    current_time = I18n.l(Time.zone.now, format: :long)
    slack.notify(
      NOTIFY_SUBJECT,
      'tamashii-clockin',
      '上班'
    )
  end

  task clockout: :environment do
    slack = FlowdockService.new(Settings.slack.token)
    slack.notify(
      NOTIFY_SUBJECT,
      '下班時間快到了，下班也要打卡喔！',
      '下班'
    )
  end
end
