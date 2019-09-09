module.exports = function () {
  var ctx = 'feedback'
  function sendFeedback (el) {
    if (!window.ga) return
    window.ga('send', 'event', {
      eventCategory: el.dataset && el.dataset.title,
      eventAction: 'click',
      eventLabel: window.location.href
    })
  }
  document.addEventListener('DOMContentLoaded', function () {
    const feedbackEl = document.querySelector('.' + ctx)
    feedbackEl.querySelectorAll('button').forEach(function (el) {
      el.addEventListener('click', function () {
        feedbackEl
          .querySelector('.' + ctx + '--actions')
          .classList.add(ctx + '--hide')
        feedbackEl
          .querySelector('.' + ctx + '--result')
          .classList.add(ctx + '--show')
        sendFeedback(el)
      })
    })
  })
}
