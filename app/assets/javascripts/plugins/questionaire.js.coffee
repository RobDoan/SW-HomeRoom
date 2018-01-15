class Questionair
  constructor: (element)->
    console.info(element)
    @element = element
    $(element).find('input').on('change.homeroom', @showNextQuestionOnEnter)

  showNextQuestionOnEnter: (event)=>
    console.info(event)
    currentQuestion = parseInt($(@element).data('question'), 10)
    nextQuestion = currentQuestion + 1
    if $(".question[data-question=#{nextQuestion}]").length > 0
      $(".question[data-question=#{nextQuestion}]").slideDown(500)
      $(".question[data-question=#{nextQuestion}]").find('input:first').focus()
    else
      $('.finish-cover').removeClass('d-none')

$.fn.questionair = (option) ->
  this.each(() ->
    element = $(this)
    questionair = element.data('homeroom.questionair')
    if !questionair
      element.data('homeroom.questionair', new Questionair(element))
  )

