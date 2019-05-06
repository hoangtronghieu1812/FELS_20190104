$('document').ready(function(){
  var word_answers = $('.word-answers');
  word_answers.hide();
  word_answers.eq(0).show();
  $('.btn-done').hide();
  $('.btn-next').on('click', function(e){
    e.preventDefault();
    index = $('.word-answers:visible').data('id')
    word_answers.eq(index).hide();
    word_answers.eq(index + 1).show();

    $('#question-number').html(index + 2)
    if (index == word_answers.length -2){
      $('.btn-done').show();
      $('.btn-next').hide();
    }
  });

  $('input[type=radio]').each(function(){
    var state = JSON.parse( localStorage.getItem('radio_'  + $(this)
      .attr('id')) );
    if (state) this.checked = state.checked;
  });

  $(window).on('unload', function(){
    $('input[type=radio]').each(function(){
      localStorage.setItem('radio_' + $(this).attr('id'),
        JSON.stringify({checked: this.checked})
      );
    });
  })

  $(window).on('load', function(){
    localStorage.clear();
  });
});
