$('document').ready(function(){
    $(document).on("change", "#condition", function(){
   $.ajax( {
        url: "/words",
        method: 'GET',
        data: {
          condition: $('#condition').val()
        },
        success: function( data ) {
          response( data );
        }
      });
  });
});
