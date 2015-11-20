N2A = null
n2A = null

module.exports =

  config:
    isUpperCase:
      title: 'Used upper case.'
      description: '\\u30cd -> \\u30CD'
      type: 'boolean'
      default: false

  # Public: Activates the package.
  activate: ->
    @commands = atom.commands.add 'atom-workspace',
      'n2-a:toNative': =>
        @loadModule()
        n2A.toNative()

      'n2-a:toAscii': =>
        @loadModule()
        n2A.toAscii()

  deactivate: ->
    @commands.dispose()

  # Private: Loads the module on-demand.
  loadModule: ->
    N2A ?= require './n2-a-cls'
    n2A ?= new N2A()
