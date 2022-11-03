colors = require "../src/index"

console.log "hello!".yellow
ret = colors.yellow("hello!")
console.log ret

console.log "hello!".yellow.underline
console.log colors.yellow.underline("hello!")
console.log colors.red.strikethrough("hello!")
console.log colors.green.inverse("hello!")

