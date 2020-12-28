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
                message = {
                  type: 'text',
                  text: ["大吉", "中吉", "小吉", "凶", "大凶"].shuffle.first
                }
              elsif event.message['text'].include?("天気")
                message = {
                  type: 'text',
                  text: ["今日は快晴です", "今日は大雨です", "今日は曇りです", "今日は雪が降るかもしれません", "曇り時々雨"].shuffle.first
                }
              elsif event.message['text'].include?("おはよう")
                message = {
                  type: 'text',
                  text: ["おはようございます🌞", "昨日はよく眠れたかな？", "おはよう！！", "ZZZ...", "おはよう、気持ちの良い朝ですね！！"].shuffle.first
                  # emojis: {
                  #   index: 0,
                  #   productId: "5ac21184040ab15980c9b43a",
                  #   emojiId: "015"
                  # }
                }
              elsif event.message['text'].include?("おやすみ")
                message = {
                  type: 'text',
                  text: ["おやすみなさい😴", "８時間は寝ましょう！！", "おはよう！！", "ZZZZZZZZZZ...", "眠れない。。"].shuffle.first
                  # emojis: {
                  #   index: 0,
                  #   productId: "5ac21184040ab15980c9b43a",
                  #   emojiId: "015"
                  # }
                }
              elsif event.message['text'].include?("じゃんけん")
                message = {
                  type: 'text',
                  text: "ぐー、ちょき、ぱーのどれかを出してね。じゃんけんぽん！"
                }
              elsif event.message['text'].include?("ぐー")
                message = [{
                  type: 'text',
                  text: "ぐー!あいこ！"
                },
                {
                  type: 'text',
                  text: "ちょき!私の負け。。"
                },
                {
                  type: 'text',
                  text: "ぱー！私の勝ち！"
                },
                {
                  type: 'text',
                  text: "ちょき！強すぎない。。"
                }].shuffle.first
              elsif event.message['text'].include?("ちょき")
                message = [{
                  type: 'text',
                  text: "ぐー!私の勝ち！！"
                },
                {
                  type: 'text',
                  text: "ちょき!あいこ！"
                },
                {
                  type: 'text',
                  text: "ぱー！私の負け。。"
                }].shuffle.first
              elsif event.message['text'].include?("ぱー")
                message = [{
                  type: 'text',
                  text: "ぐー!私の負け。。"
                },
                {
                  type: 'text',
                  text: "ちょき!私の勝ち！"
                },
                {
                  type: 'text',
                  text: "ぱー！あいこ！"
                }].shuffle.first
              else 
                message = {
                  type: 'text',
                  text: @post.name
                }
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
              },
              {
                type: 'sticker',
                packageId: '11537',
                stickerId: '52002760'
              },
              {
                type: 'sticker',
                packageId: '11537',
                stickerId: '52002740'
              },
              {
                type: 'sticker',
                packageId: '11537',
                stickerId: '52002771'
              }].shuffle.first
          end
          client.reply_message(event['replyToken'], message)
      end
    }

    head :ok
  end
end
