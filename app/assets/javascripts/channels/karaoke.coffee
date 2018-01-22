App.karaoke = App.cable.subscriptions.create "KaraokeChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    
    unless data.playlist.nil?
        $('#karaokePlaylist1').replaceWith data.playlist
    
    unless data.player_status.nil?
        $('#playerStatusContainer').replaceWith data.player_status
