
module.exports =
class N2A

  toNative: (@editor=atom.workspace.getActiveTextEditor()) ->
    return unless @editor?
    @convert(@editor.buffer, 'native')

  toAscii: (@editor = atom.workspace.getActiveTextEditor()) ->
    return unless @editor?
    @convert(@editor.buffer, 'ascii')

  convert: (buffer, type) ->
    word = buffer.getText()
    switch type
      when 'native' then buffer.setText(@aton(word))
      when 'ascii' then buffer.setText(@ntoa(word))

  # Native to Ascii
  #
  # * `word` {String} active text
  ntoa: (word) ->

    ascii = ''

    while word.length > 0

      t = word.substring(0, 1)
      tmp = t.charCodeAt().toString(16)

      word = word.substring(1)

      if tmp.length >= 4
        ascii += '\\u' + tmp
      else
        ascii += t

    ascii

  # Ascii to Native
  #
  # * `word` {String} active text
  aton: (word) ->

    na = ''
    codePattern = /\\u[0-9A-Fa-f]{4}/

    while word.length > 0

      hit = codePattern.exec word
      index = hit?.index

      unless index?
        na += word
        break

      na = na + word.substring(0, index) if 0 < index

      if (index + 6) <= word.length
        tmp = parseInt(word.substring(index + 2, index + 6), 16)
        na += String.fromCharCode(tmp)
        word = word.substring(index + 6)
      else
        break

    na
