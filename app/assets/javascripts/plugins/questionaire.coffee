class Questionair
  constructor: (element)->
    @element = element
    $(element).on('change.homeroom', '.input', @showNextQuestionOnEnter)


  showNextQuestionOnEnter: (event)=>
    currentQuestion = parseInt($(@element).data('question'), 10)
    nextQuestion = currentQuestion + 1
    $(".question[data-question=#{nextQuestion}]").show()


$.fn.questionair = (option) ->
  this.each(() ->
    element = $(this)
    questionair = element.data('homeroom.questionair')
    if questionair
      element.data('homeroom.questionair', new Questionair(element))
  )
