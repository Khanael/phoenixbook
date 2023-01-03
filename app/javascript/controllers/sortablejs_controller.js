import { Controller } from '@hotwired/stimulus'
import Sortable from 'sortablejs'

// Connects to data-controller="sortablejs"
export default class extends Controller {
  static targets = ['list', 'book', 'position']

  connect() {
    // Create a new Sortable instance for each book and change the position of the books in the bookshelf database when the user drags and drops them
    this.sortable = Sortable.create(this.listTarget, {
      animation: 150,
      onEnd: this.updatePositions.bind(this),
    })
    console.log(this.bookTargets)
  }

  updatePositions() {
    // Get the new positions of the books in the bookshelf by mapping over the book targets and returning an object with the position and bookbookshelf_id
    const positions = this.bookTargets.map((book, index) => {
      return {
        position: index + 1,
        bookbookshelf_id: book.dataset.bookbookshelfId,
      }
    })

    console.log(positions)
    const bookshelfId = this.listTarget.dataset.bookshelfId
    // Send the new positions to the server
    fetch(`/bookshelves/${bookshelfId}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')
          .content,
      },
      body: JSON.stringify({
        positions: positions,
      }),
    }).then((response) => {
      if (response.ok) {
        console.log('ok', this.positionTargets)
        this.positionTargets.forEach((position, index) => {
          console.log('Positions updated')
          position.innerText = index + 1
        })
      }
    })
  }
}
