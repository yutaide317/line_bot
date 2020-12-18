class LineBotsController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'

  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback

    # Postモデルの中身をランダムで@postに格納する
    @post=Post.offset( rand(Post.count) ).first
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end
    
    events = client.parse_events_from(body)

    events.each { |event|

      case event
        when Line::Bot::Event::Message
          case event.type
            when Line::Bot::Event::MessageType::Text
              if event.message['text'].include?("運勢")
                message[:text] =
                  [["大吉", "中吉", "小吉", "凶", "大凶"].shuffle.first]
            　else
              end
            when Line::Bot::Event::MessageType::Sticker
              message = [{
                type: 'sticker',
                packageId: '11537',
                stickerId: '52002734'
              },
              {
                type: 'sticker',
                packageId: '11537',
                stickerId: '52002736'
              }].shuffle.first
          end
          client.reply_message(event['replyToken'], message)
      end
    }

    head :ok
  end
end
