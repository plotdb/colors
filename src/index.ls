codes =
  reset: [0 0]
  bold: [1 22]
  dim: [2 22]
  italic: [3 23]
  underline: [4 24]
  inverse: [7 27]
  hidden: [8 28]
  strikethrough: [9 29]
  black: [30 39]
  red: [31 39]
  green: [32 39]
  yellow: [33 39]
  blue: [34 39]
  magenta: [35 39]
  cyan: [36 39]
  white: [37 39]
  gray: [90 39]
  grey: [90 39]
  brightRed: [91 39]
  brightGreen: [92 39]
  brightYellow: [93 39]
  brightBlue: [94 39]
  brightMagenta: [95 39]
  brightCyan: [96 39]
  brightWhite: [97 39]
  bgBlack: [40 49]
  bgRed: [41 49]
  bgGreen: [42 49]
  bgYellow: [43 49]
  bgBlue: [44 49]
  bgMagenta: [45 49]
  bgCyan: [46 49]
  bgWhite: [47 49]
  bgGray: [100 49]
  bgGrey: [100 49]
  bgBrightRed: [101 49]
  bgBrightGreen: [102 49]
  bgBrightYellow: [103 49]
  bgBrightBlue: [104 49]
  bgBrightMagenta: [105 49]
  bgBrightCyan: [106 49]
  bgBrightWhite: [107 49]

colors =
  enabled: true
  enable: -> @enabled = true
  disable: -> @enabled = false
  codes: codes

wrap = (v) -> "#{wrap.pre or ''}#v#{wrap.post or ''}"

for k,v of codes =>
  String.prototype.__defineGetter__(
    k,
    ((v)->->if colors.enabled => "\u001b[#{v.0}m#{@}\u001b[#{v.1}m" else "#{@}")(v)
  )
  ((k,v) ->
    # first access clear wrap stack
    Object.defineProperty colors, k, do
      get: ->
        wrap.pre = wrap.post = ''
        wrap[k]
    # successor access stack values in `pre` and `post` member.
    Object.defineProperty wrap, k, do
      get: ->
        wrap.pre = (wrap.pre or '') + "\u001b[#{v.0}m"
        wrap.post = "\u001b[#{v.1}m" + (wrap.post or '')
        wrap
  )(k,v)

module.exports = colors
