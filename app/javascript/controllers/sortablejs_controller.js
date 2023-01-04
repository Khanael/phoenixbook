import { Controller } from '@hotwired/stimulus'
import Sortable from 'sortablejs'

// Connects to data-controller="sortablejs"
export default class extends Controller {
  connect() {
    // Create a new Sortable instance for each book and change the position of the books in the bookshelf database when the user drags and drops them
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      onEnd: this.updatePositions.bind(this),
    })
    console.log(this.bookTargets)
  }

  updatePositions(event) {
    // Get the new positions of the books in the bookshelf by mapping over the book targets and returning an object with the position and bookbookshelf_id
    let id = event.item.dataset.id
    // Send the new positions to the server
    fetch(`/book_bookshelves/${id}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')
          .content,
      },
      body: JSON.stringify({
        book_bookshelf_id: id,
        position: event.newIndex + 1,
      }),
    }).then((response) => {
      if (response.ok) {
        console.log('success')
      }
    })
  }
}
