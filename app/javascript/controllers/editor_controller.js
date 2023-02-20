import { Controller } from "@hotwired/stimulus"

import {EditorState} from "@codemirror/state"
import {EditorView, lineNumbers, keymap} from "@codemirror/view"
import {defaultKeymap} from "@codemirror/commands"

import StimulusPlugin from "../codemirror/stimulus_plugin"

// Connects to data-controller="editor"
export default class extends Controller {
  static targets = [
    "source",
    "fromA",
    "toA",
    "fromB",
    "toB",
    "inserted",
    "submit",
  ]

  connect() {
    let startState = EditorState.create({
      doc: this.sourceTarget.value,
      extensions: [
        keymap.of(defaultKeymap),
        lineNumbers(),
        EditorView.lineWrapping,
        StimulusPlugin(this),
      ]
    })

    this.view = new EditorView({
      state: startState,
      parent: this.element,
    })
  }

  sync(codemirrorChange) {
    this.fromATarget.value = codemirrorChange.fromA;
    this.toATarget.value = codemirrorChange.toA;
    this.fromBTarget.value = codemirrorChange.fromB;
    this.toBTarget.value = codemirrorChange.toB;
    this.insertedTarget.value = codemirrorChange.inserted.text.join("\n");
    this.submitTarget.click();
  }
}
