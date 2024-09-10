import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ 'bar' ]

    addNote(event) {
        event.srcElement.className = "note_tab contains_note"

    }

    connect() {
        // ?
    }
}