$ ->
  if $("#loader").length
    window.setTimeout(poll, 5000)

window.poll_number = 0

window.messages = [
  "Waking up the robots..."
  "Sifting the playlists..."
  "Hey how did Nickelback get in here?"
  "Crunching the numbers..."
  "Coming in like a wrecking ball..."
  "Whew, you have a lot of music!"
  "What does the fox say?"
  "Compiling the stats..."
]

window.poll = ->
  $.get '/spotify/progress', (data) ->
    if data
      window.location = '/spotify/results'

  $('#loader_text').transition('browse', 500, ->
    window.setTimeout(
      (->
        $('#loader_text').html(window.messages[poll_number])
        poll_number += 1
        $('#loader_text').transition('browse')
        window.setTimeout(poll, 5000)
      ),
      1000)
  )
