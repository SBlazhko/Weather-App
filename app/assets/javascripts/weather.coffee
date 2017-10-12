$(document).ready ->
  $.ajax(
    url: '/weather/authorise'
    method: 'POST'
    data:
      secret_user_key: getCookie("weather_app_user_key")
  ).done((data) =>

  ).fail (data) ->


@getCookie = (cname) ->
  name = cname + '='
  decodedCookie = decodeURIComponent(document.cookie)
  ca = decodedCookie.split(';')
  i = 0
  while i < ca.length
    c = ca[i]
    while c.charAt(0) == ' '
      c = c.substring(1)
    if c.indexOf(name) == 0
      return c.substring(name.length, c.length)
    i++
