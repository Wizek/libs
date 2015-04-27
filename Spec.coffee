describe 'reDomain', ->
  describe 'move', ->
    Then  -> (reDomain 0, 1, 10, 11, 0) == 10
    Then  -> (reDomain 0, 1, 10, 11, 1) == 11
    Then  -> (reDomain 1, 2, 10, 11, 1) == 10

  describe 'scale', ->
    Then  -> (reDomain 1, 3, 1, 5, 1) == 1
    Then  -> (reDomain 1, 3, 1, 5, 2) == 3
    Then  -> (reDomain 1, 3, 1, 5, 3) == 5

  describe 'move and scale', ->
    Then  -> (reDomain 1, 3, 11, 15, 1) == 11
    Then  -> (reDomain 1, 3, 11, 15, 2) == 13
    Then  -> (reDomain 1, 3, 11, 15, 3) == 15

  describe 'invert', ->
    Then  -> (reDomain 1, 3, 3, 1, 1) == 3
    Then  -> (reDomain 1, 3, 3, 1, 2) == 2
    Then  -> (reDomain 1, 3, 3, 1, 3) == 1

  describe 'curried', ->
    Then  -> (reDomain 0, 2)(0, 4)(1) == 2

describe 'jsToHs', ->
  describe 'value', ->
    Then  -> expect(jsToHs "a").toBe "a"
    Then  -> expect(jsToHs "f(a)").toBe "(f a)"
    Then  -> expect(jsToHs "function (a) { return a }").toBe "(\\a -> a)"
    # Then  -> expect(jsToHs "function () { return a }").toBe "(\\a -> a)"
    Then  -> expect(jsToHs "function (a) { return fn(a, fn(b)) }").toBe "(\\a -> (fn a (fn b)))"
    Then  -> expect(jsToHs "a || b").toBe "(or a b)"
