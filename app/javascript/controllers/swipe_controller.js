import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="swipe"
export default class extends Controller {
  connect() {}

  touch() {
    let touchstartX = 0
    let touchendX = 0
    touchstartX = e.changedTouches[0].screenX
    touchendX = e.changedTouches[0].screenX
    checkDirection()
  }

  checkDirection() {
    if (touchendX < touchstartX) console.log('swiped left!')
    if (touchendX > touchstartX) console.log('swiped right!')
  }
}
