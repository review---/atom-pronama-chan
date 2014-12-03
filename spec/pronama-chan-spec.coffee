{WorkspaceView} = require 'atom'
PronamaChan = require '../lib/pronama-chan'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "PronamaChan", ->
  activationPromise = null
  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('atom-pronama-chan')

    waitsForPromise ->
      activationPromise

  describe "when the atom-pronama-chan activated", ->
    it "add pronama-chan class to workspace", ->
      expect(atom.workspaceView.hasClass('pronama-chan')).toEqual(true)
      expect(PronamaChan.audio.src).not.toBeUndefined()

  describe "when the atom-pronama-chan:toggle event is triggered", ->
    it "toggle pronama-chan class to workspace", ->
      atom.workspaceView.trigger 'atom-pronama-chan:toggle'

      runs ->
        expect(atom.workspaceView.hasClass('pronama-chan')).toEqual(false)

    it "toggle twice pronama-chan class to workspace", ->
      atom.workspaceView.trigger 'atom-pronama-chan:toggle'
      atom.workspaceView.trigger 'atom-pronama-chan:toggle'

      runs ->
        expect(atom.workspaceView.hasClass('pronama-chan')).toEqual(true)

  describe "Pronamachan methods", ->
    orgSrc = null
    beforeEach ->
      orgSrc = PronamaChan.audio.src

    it "speak method sucess", ->
      runs ->
        expect(PronamaChan.audio.src).not.toBeUndefined()
        PronamaChan.speak atom.config.get("atom-pronama-chan.startVoice.morning")
        expect(PronamaChan.audio.src).not.toEqual(orgSrc)

    it "speak method nothing to do when pronama-chan is hidden", ->
      runs ->
        PronamaChan.speak atom.config.get("")
        expect(PronamaChan.audio.src).toEqual(orgSrc)

    it "speak method fail file is not exists", ->
      runs ->
        PronamaChan.speak "test"
        expect(PronamaChan.audio.src).toEqual(orgSrc)

    it "is morning from", ->
      PronamaChan.StartVoice new Date("2014/01/01 6:00")

      runs ->
        expect(PronamaChan.audio.src).toContain(atom.config.get("atom-pronama-chan.startVoice.morning"))

    it "is morning to", ->
      PronamaChan.StartVoice new Date("2014/01/01 11:59")

      runs ->
        expect(PronamaChan.audio.src).toContain(atom.config.get("atom-pronama-chan.startVoice.morning"))

    it "is afternoon from", ->
      PronamaChan.StartVoice new Date("2014/01/01 12:00")

      runs ->
        expect(PronamaChan.audio.src).toContain(atom.config.get("atom-pronama-chan.startVoice.afternoon"))

    it "is afternoon to", ->
      PronamaChan.StartVoice new Date("2014/01/01 17:59")

      runs ->
        expect(PronamaChan.audio.src).toContain(atom.config.get("atom-pronama-chan.startVoice.afternoon"))

    it "is night from", ->
      PronamaChan.StartVoice new Date("2014/01/01 18:00")

      runs ->
        expect(PronamaChan.audio.src).toContain(atom.config.get("atom-pronama-chan.startVoice.night"))

    it "is night to", ->
      PronamaChan.StartVoice new Date("2014/01/02 5:59")

      runs ->
        expect(PronamaChan.audio.src).toContain(atom.config.get("atom-pronama-chan.startVoice.night"))

    it "is night to", ->
      PronamaChan.StartVoice new Date("2014/01/02 5:59")

      runs ->
        expect(PronamaChan.audio.src).toContain(atom.config.get("atom-pronama-chan.startVoice.night"))
