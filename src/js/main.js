const Menu = require('./menu')

function setup () {
  document.documentElement.classList.add('interactive')

  const menuElement = document.querySelector('.sidebar-nav')
  if (menuElement) {
    const menu = new Menu(menuElement)
    for (let button of document.querySelectorAll('.menu-button')) {
      button.addEventListener('click', event => menu.show())
    }
  }
}

const requiredFeatures = document.querySelector &&
  document.body.classList &&
  document.body.contains

if (requiredFeatures) {
  setup()
} else if (window.console) {
  window.console.log('This browser is not fancy enough for our scripts!')
}
