import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="selection"
export default class extends Controller {
  static targets = [
    "article",
    "selectionStart",
    "selectionStartOffset",
    "selectionEnd",
    "selectionEndOffset",
    "comment",
    "submit",
  ]

  highlight(_) {
    let selection = document.getSelection();
    if (selection.isCollapsed) { return; };
    if (selection.rangeCount != 1) {
      debugger;
      console.log("selection.rangeCount != 1");
      return;
    };
    let range = selection.getRangeAt(0);

    this.commentTarget.value = "foo";

    this.selectionStartTarget.value = this.document_path_to(range.startContainer);
    this.selectionEndTarget.value = this.document_path_to(range.endContainer);
    this.selectionStartOffsetTarget.value = range.startOffset;
    this.selectionEndOffsetTarget.value = range.endOffset;

    this.submitTarget.click();
  }

  document_path_to(selection_node) {
    let target = selection_node;
    if (target.nodeType != document.ELEMENT_NODE) {
      target = selection_node.parentElement;
    };

    let walker = document.createTreeWalker(
      this.articleTarget,
      NodeFilter.SHOW_ELEMENT,
    );

    let stack = [""];

    while (walker.currentNode != target) {
      let node = walker.firstChild();
      if (node != null) {
        stack.push(0);
        continue;
      }

      // No children, go to next sibling
      node = walker.nextSibling();
      if (node != null) {
        stack[stack.length - 1] += 1;
        continue;
      }

      while (node == null) {
        // No more siblings, go to parent's next sibling
        node = walker.parentNode();
        stack.pop();

        if (node == this.articleTarget) {
          console.log("Selection not found.");
          return;
        }

        node = walker.nextSibling();
        stack[stack.length - 1] += 1;
      }
    }

    return stack.join(".");
  }
}
