import { Controller } from '@hotwired/stimulus'
import Hammer from 'hammerjs'

// Connects to data-controller="swipe"
export default class extends Controller {
  connect() {
    var hammertime = new Hammer(this.element)
    console.log(this.element.dataset.id)
    const id = this.element.dataset.id

    hammertime.on('swipeleft', function (ev) {
      console.log(ev)
      if (ev.direction == 2) {
        console.log('swipe left')
        fetch(`/books/${id}/votes`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')
              .content,
          },
          body: JSON.stringify({ liked: 'true' }),
        }).then((response) => {
          if (response.ok) {
            console.log('success')
            window.location.reload()
          }
        })
      }
    })

    hammertime.on('swiperight', function (ev) {
      if (ev.direction == 4) {
        console.log('swipe right')

        fetch(`/books/${id}/votes`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')
              .content,
          },
          body: JSON.stringify({ liked: 'false' }),
        }).then((response) => {
          if (response.ok) {
            console.log('success')
            window.location.reload()
          }
        })
      }
    })
  }
}
