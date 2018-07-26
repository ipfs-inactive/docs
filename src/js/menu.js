/**
 * Manage dynamically showing/hiding the menu on small screens.
 */
class Menu {
  constructor (element) {
    this.isShowing = false
    this.isFocusInside = false
    this.element = element
    this.closeButton = this.element.querySelector('.close-button')
    this.main = document.querySelector('main')

    // prevent any animations during setup
    this.element.style.transition = 'none'
    setTimeout(() => (this.element.style.transition = ''), 10)
    this.element.classList.add('interactive')
    ensureFocusable(this.element)

    // create the overlay
    this.overlay = document.createElement('div')
    this.overlay.className = 'sidebar-nav--overlay'
    document.body.appendChild(this.overlay)

    this.addListener('click')
    this.addListener('keydown')
    this.addListener('click', 'onclickOverlay', this.overlay)
    this.addListener('transitionend', 'ontransitionendOverlay', this.overlay)
    this.addListener('focus', 'onfocusWindow', window, true)
  }

  // PUBLIC INTERFACE ---------------------------------

  show () {
    this.triggerElement = document.activeElement
    this.isShowing = true
    this.overlay.style.display = 'block'
    this.overlay.classList.add('active')
    this.element.classList.add('active')
    if (this.main) {
      this.main.setAttribute('aria-hidden', 'true')
    }

    // Safari won't make the focused area interactive if it receives focus
    // during a transition, so delay moving focus a bit.
    setTimeout(() => this.element.focus(), 300)
  }

  hide () {
    this.isShowing = false
    this.overlay.classList.remove('active')
    this.element.classList.remove('active')
    if (this.main) {
      this.main.removeAttribute('aria-hidden')
    }

    if (this.isFocusInside) {
      const focusNode = this.element.nextElementSibling ||
        this.main ||
        document.body
      focusWithoutScroll(focusNode)
    }
  }

  // PRIVATE INTERFACE ---------------------------------

  addListener (eventName, handler = null, target = null, capture = false) {
    target = target || this.element
    handler = handler || `on${eventName}`
    this[handler] = this[handler].bind(this)
    target.addEventListener(eventName, this[handler], capture)
  }

  onclick (event) {
    if (this.closeButton.contains(event.target)) {
      this.hide()
      return
    }

    // Walk up the tree to see if we clicked on something that should navigate
    // and hide the menu if so.
    let node = event.target
    while (node) {
      if (node.nodeName === 'A' || node.nodeName === 'BUTTON') {
        this.hide()
        return
      }
      node = node.parentNode
    }
  }

  onclickOverlay () {
    this.hide()
  }

  ontransitionendOverlay (event) {
    if (!this.overlay.classList.contains('active')) {
      this.overlay.style.display = 'none'
    }
  }

  onkeydown (event) {
    // esc key
    if (event.keyCode === 27) {
      this.hide()
    }
  }

  onfocusWindow (event) {
    const target = (event.target && event.target.nodeType) ? event.target : document.body
    this.isFocusInside = this.element.contains(target)
    if (this.isShowing && !this.isFocusInside) {
      this.hide()
    }
  }
}

function ensureFocusable (element) {
  if (!element.hasAttribute('tabindex')) {
    element.setAttribute('tabindex', '-1')
  }
}

// A very imperfect way to prevent scrolling when moving focus
function focusWithoutScroll (element) {
  const scrollX = window.pageXOffset
  const scrollY = window.pageYOffset
  ensureFocusable(element)
  element.focus({preventScroll: true})
  window.scrollTo(scrollX, scrollY)
}

module.exports = Menu
