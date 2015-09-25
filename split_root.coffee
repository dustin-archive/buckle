module.exports = (open, close, split, string) ->
  balance = 0
  items = []
  last = 0

  if open instanceof RegExp
    match = string.match(open)
    open = match[0] if match

  if close instanceof RegExp
    match = string.match(close)
    close = match[0] if match

  if split instanceof RegExp
    match = string.match(split)
    split = match[0] if match

  for i in [0..string.length]
    balance++ if string[i] == open
    balance-- if string[i] == close

    end = i + split.length
    if string.slice(i, end) == split && !balance
      items.push(string.slice(last, i))
      last = end
    else if i == string.length
      items.push(string.slice(last))

  return items
