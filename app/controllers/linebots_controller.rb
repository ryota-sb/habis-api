class LinebotsController < ApplicationController
  require 'line/bot'
  require 'date'

  protect_from_forgery :except => [:callback, :getLinkToken]

  # 完了タスクのリセット
  def reset_tasks(week)
    tasks = Task.where(is_done, true, week, week)
    tasks.update.all(is_done: false)
    return '今日のタスクをリセットしました！'
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)

    events.each do |event|
      reply_text_list = []
      case event.message['text']
      when 'リセット'
        reply_text_list.push(reset_tasks(get_day_of_the_week))
      else
        reply_text_list.push('そのコマンドはありません')
      end

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message_array = reply_text_lists.map do |reply_text|
            { type: 'text', text: reply_text }
          end
          client.reply_message(event['replyToken'], message_array)
        end
      end
    end
    head :ok
  end

  def getLinkToken
    body = request.body.read
    events = client.parse_events_from(body)
    events.each do |event|
      userId = event["source"]["userId"]
      linkToken = client.create_link_token(userId)
      case event.message['text']
      when '連携'
        client.reply_message(event['replyToken'], template(userId, linkToken))
      else
        "コマンドはありません。"
      end
    end
  end

  def template(user_id, link_token)
    {
      "to": "#{user_id}",
      "messages": [{
          "type": "template",
          "altText": "Account Link",
          "template": {
              "type": "buttons",
              "text": "Account Link",
              "actions": [{
                  "type": "uri",
                  "label": "Account Link",
                  "uri": "http://example.com/link?linkToken=#{link_token}"
              }]
          }
      }]
    }
  end

  private

  # Lineアカウント取得
  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end
  end

  # 今日の曜日をリスト内の文字列で取得
  def get_day_of_the_week
    data = Date.today
    week_lists = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday']
    return week_lists[data.wday]
  end
end
