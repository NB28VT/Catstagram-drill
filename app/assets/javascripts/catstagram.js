$(document).ready(function() {
  $('[data-post-id]').on('submit', '[data-meow-button="create"]', function(event) {
    event.preventDefault();

    $form = $(event.currentTarget);

    $.ajax({
      type: "POST",
      url: $form.attr('action'),
      dataType: "json",
      success: function(meow){
        // Create the string version of the form action
        action = '/posts/' + meow.post_id + '/meows/' + meow.id;

        // Create the new form
        $newForm = $('<form>').attr({
          action = action,
          method: 'delete',
          'data-meow-button': 'delete'
        });

        // Create the new submit input
        $meowButton = $('<input>').attr({type: 'submit', value: 'Remove Meow'});

        // Append the new submit input to the new form
        $newForm.append($meowButton);

        // Relace the old create form with the new remove form
        $form.replaceWith($newForm);
      }
    });
  });

  $('[data-meow-button="delete"]').on('submit', function(event){
    event.preventDefault();

    $.ajax({
      type: "DELETE",
      url: $form.attr('action'),
      dataType: "json",
      success: function(){
        alert("MEOW DELETED!");
      }
    });
  });
});
