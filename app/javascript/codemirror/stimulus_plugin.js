import {ViewPlugin} from "@codemirror/view"

export default function(controller) {
  return ViewPlugin.fromClass(class {
    constructor(view) {
      this.view = view;
      this.controller = controller;
    }

    update(update) {
      if (update.docChanged) {
        update.changes.iterChanges(
          (fromA, toA, fromB, toB, inserted) => {
            this.controller.sync({
              fromA: fromA,
              toA: toA,
              fromB: fromB,
              toB: toB,
              inserted: inserted,
            })
          },
          true,
        )
      }
    }

    destroy() {}
  })
}
