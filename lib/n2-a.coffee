N2A = null
n2A = null

module.exports =

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
    @commands.destroy()

  # Private: Loads the module on-demand.
  loadModule: ->
    N2A ?= require './n2-a-cls'
    n2A ?= new N2A()
