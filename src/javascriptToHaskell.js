"require http://pegjs.org/vendor/pegjs/peg.js"

var jsToHsGrammar = [
  'js',
  '  = statement',

  'statement',
  '  = ("return" _)? x:expression { return x }',

  'expression',
  '  = operated',
  '  / function',
  '  / fnCall',

  'fnCall ',
  '  = name:name _ "(" args:arguments ")" { return "(" + name + " " + args.join(" ") + ")"}',
  '  / name',

  'operated = a:fnCall _ op:op _ b:fnCall { return "(" + [op, a, b].join(" ") + ")"}',

  'op "op" = _ "||" _ { return "or" }',

  'arguments = _ x:argument xs:(_ "," _ x:argument { return x})* _ { return [x].concat(xs) }',
  'argument = expression',
  'function = _ "function" _ "(" args:argumentDefs ")" _ "{" _',
  '  body:js ',
  '_ "}" { return "(\\\\" + args.join(" ") + " -> " + body + ")" }',

  'argumentDefs = _ x:argumentDef xs:(_ "," _ x:argumentDef { return x })* _ { return [x].concat(xs) }',

  'argumentDef = name',

  'name = $ [A-Za-z.]+',

  '_ = whitespace*',
  's = whitespace+',
  'whitespace "Whitespace" = [ \\n\\t\\r]',
].join('\n')

var jsToHs = PEG.buildParser('start = js\n' + jsToHsGrammar).parse
