function showCollaborationMessage(list, messages) {
  var $containers = $('section.collaboration').hide(),
      $lists = $('section.collaboration ul').empty();

  for (var i = 0; i < messages.length; i++) {
    $("<li></li>").html(messages[i]).appendTo(list);
  }

  list.parent().parent().fadeIn(1000);
}

$(document).on('ready page:load', function() {
  $('#new_collaboration').on('submit', function(event) {
    var $this = $(this),
        action = $this.attr('action'),
        method = $this.attr('method'),
        data = $this.serialize();

    event.preventDefault();

    if ($('#collaboration_user').val().length === 0) {
      return false;
    } else {
      $.ajax({
        url: action,
        method: method,
        data: data,
        dataType: 'json',
      }).done(function(result) {
        if (result.success) {
          showCollaborationMessage($('section.collaboration ul.confirm'), result.confirm);
        } else {
          showCollaborationMessage($('section.collaboration ul.errors'), result.errors);
        }
      });
    }

  });
});