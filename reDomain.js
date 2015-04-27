"require github://ramda/ramda/dist/ramda.js"

var reDomain = R.curry(function (l, h, nl, nh, v) {
  return (v - l) / (l - h) * (nl - nh) + nl
})
