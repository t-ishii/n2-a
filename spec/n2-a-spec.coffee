N2A = require '../lib/n2-a'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "N2A", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('n2-a')

  describe "when the n2-a:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.n2-a')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'n2-a:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.n2-a')).toExist()

        n2AElement = workspaceElement.querySelector('.n2-a')
        expect(n2AElement).toExist()

        n2APanel = atom.workspace.panelForItem(n2AElement)
        expect(n2APanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'n2-a:toggle'
        expect(n2APanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.n2-a')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'n2-a:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        n2AElement = workspaceElement.querySelector('.n2-a')
        expect(n2AElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'n2-a:toggle'
        expect(n2AElement).not.toBeVisible()
