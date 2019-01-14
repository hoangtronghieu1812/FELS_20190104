$('document').ready(function(){
  $(document).on("change", "#condition", function(){
    $.ajax( {
      url: "/words",
      method: 'GET',
      data: {
      condition: $('#condition').val()
      }
    })
    .done(function() {
      history.pushState(null, null, this.url);
    })
  });
  $(window).on("popstate", function() {
    $.get(location.href);
  });
})

