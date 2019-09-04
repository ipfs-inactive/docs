module.exports = function () {
  function sendFeedback (el) {
    if (!window.ga) return
    window.ga('send', 'event', {
      eventCategory: el.title.toLowerCase(),
      eventAction: 'click',
      eventLabel: window.location.pathname
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
        sendFeedback(el)
      })
    })
  })
}
