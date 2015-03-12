N2A = require '../lib/n2-a-cls'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "N2A", ->
  n2a = null

  beforeEach ->
    n2a = new N2A()

  describe "cherck converter", ->
    it "native -> ascii", ->
      expect(n2a.ntoa "テスト").toBe("\\u30c6\\u30b9\\u30c8")

    it "ascii -> native", ->
      expect(n2a.aton "\\u30c6\\u30b9\\u30c8").toBe("テスト")
