# frozen_string_literal: true

namespace :notification do
  NOTIFY_SUBJECT = 'Tamashii 打卡貼心提示'
  task clockin: ['flowdock:clockin', 'slack:clockin']
  task clockout: ['flowdock:clockout', 'slack:clockout']

  namespace :flowdock do
    task clockin: :environment do
      flowdock = FlowdockService.new(Settings.flowdock.token)
      counts, not_clockin_count = clockin_status
      current_time = I18n.l(Time.zone.now, format: :long)
      flowdock.notify(
        Settings.flowdock.channel,
        NOTIFY_SUBJECT,
        "現在時間 #{current_time} 打卡人數 #{counts} 人，還有 #{not_clockin_count} 人尚未打卡。",
        color: 'green',
        value: '上班'
      )
    end

    task clockout: :environment do
      flowdock = FlowdockService.new(Settings.flowdock.token)
      flowdock.notify(
        Settings.flowdock.channel,
        NOTIFY_SUBJECT,
        '下班時間快到了，下班也要打卡喔！',
        color: 'red',
        value: '下班'
      )
    end
  end

  namespace :slack do
    task clockin: :environment do
      slack = SlackService.new(Settings.slack.token)
      counts, not_clockin_count = clockin_status
      slack.notify(
        NOTIFY_SUBJECT,
        '上班打卡狀況',
        [
          {
            'title': '已打卡人數',
            'value': counts,
            'short': true
          },
          {
            'title': '未打卡人數',
            'value': not_clockin_count,
            'short': true
          }
        ]
      )
    end

    task clockout: :environment do
      slack = SlackService.new(Settings.slack.token)
      slack.notify(
        NOTIFY_SUBJECT,
        '下班時間快到了，下班也要打卡喔！',
        []
      )
    end
  end

  def clockin_status
    counts = CheckRecord.today.clockin.distinct(:user_id).count
    not_clockin_count = User.count - counts
    [counts, not_clockin_count]
  end
end
