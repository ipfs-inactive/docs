module.exports = function () {
  function sendFeedback (event) {
    if (!window.ga) return
    window.ga('send', 'event', {
      eventCategory: 'helpful',
      eventAction: 'click',
      eventLabel: window.location.href
    })
  }
  document.addEventListener('DOMContentLoaded', function () {
    const feedbackEl = document.querySelector('.feedback')
    feedbackEl.querySelectorAll('button').forEach(function (el) {
      el.addEventListener('click', function () {
        feedbackEl
          .querySelector('.feedback--actions')
          .classList.add('feedback--hide')
        feedbackEl
          .querySelector('.feedback--result')
          .classList.add('feedback--show')
        console.log(window.location.href)
      })
    })
  })
}
