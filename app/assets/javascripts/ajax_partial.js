$('document').ready(function() {

  $('div[data-async-partial]').each(function(){
    var element = $(this);
    var url = element.data('async-partial');
    $.get(url, function(data) {
      element.html(data)
    })
  })

});
