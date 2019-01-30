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

  $('input[type="checkbox"]').on('change', function() {
    $('input[name="' + this.name + '"]').not(this).prop('checked', false);
  });
});
