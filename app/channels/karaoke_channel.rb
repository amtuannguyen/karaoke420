class KaraokeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "karaoke_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
