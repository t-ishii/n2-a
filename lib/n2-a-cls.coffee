
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

      # 1文字取得
      t = word.substring(0, 1)

      # 16進数へ変換
      tmp = t.charCodeAt().toString(16)

      # 元文字列から1文字減らす
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

      # Ascii文字を含んでない場合は終了
      unless index?
        na += word
        break

      # 直前の文字がエスケープだった場合次の検索を実行
      if 0 < index and /^\\\\/.test word.substring(index - 1, index + 1)
        na += word.substring(0, index + 6)
        word = word.substring(index + 6)
        continue

      # ASCII文字直前の文字列取得
      na += word.substring(0, index) if 0 < index

      # ascii -> native
      na += String.fromCharCode(
        parseInt(word.substring(index + 2, index + 6), 16)
      )

      # 文字列の再設定
      word = word.substring(index + 6)

    na
