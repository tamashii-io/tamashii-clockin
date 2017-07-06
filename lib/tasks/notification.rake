# frozen_string_literal: true

namespace :notification do
  NOTIFY_SUBJECT = 'Tamashii 打卡貼心提示'

  task clockin: :environment do
    flowdock = FlowdockService.new(Settings.flowdock.token)
    counts = CheckRecord.today.clockin.distinct(:user_id).count
    not_clockin_count = User.count - counts
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
