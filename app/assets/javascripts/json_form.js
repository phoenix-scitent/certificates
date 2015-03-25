$(document).ready(function(){

  var toggleDependent = function(e) {
    var el = $(e.target);
    var parentId = el.closest('.field').data("id");
    var chosenOption = el.find(":selected, :checked")
    var dependentId = chosenOption.data("dependent") || el.data("dependent");

    // hide all dependent questions
    $(".dependent_"+parentId).addClass('hidden').find('input').prop('disabled', true);
    // show chosen dependent question
    $("div.field[data-id='"+dependentId+"']").removeClass('hidden').find('input, select').prop('disabled', false);

    // Iterate through checkboxes and show correct dependents only if checked
    $("input[type='checkbox']").each(function(){
      var dependentId = $(this).data("dependent")
      if (dependentId !== 'undefined') {
        if($(this).prop("checked")) {
          $("div.field[data-id='"+dependentId+"']").removeClass('hidden').find('input').prop('disabled', false);
        } else {
          $("div.field[data-id='"+dependentId+"']").addClass('hidden').find('input').prop('disabled', true);
        }
      }
    });  
  }


  $("label[required='required']").append("<abbr title='required'> *</abbr>");
  $("[data-has-dependents='true']").on('change', toggleDependent);
 
});
