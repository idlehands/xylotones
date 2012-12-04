var Xylotone = {
    deletedView: 'hidden',

   init: function() {
     $('circle').on('click', this.hideDot);
     $('#show').on('click', this.hideDeleted);
     $('#hide').on('click', this.showDeleted);
     $('button.save-image').on('click', this.saveImage);
     $('button.save-image').on('ajax:success', this.deleteDots);
   },

   hideDot: function(){
     if ($(this).hasClass("shown")){
        $(this).attr("class", Xylotone.deletedView);
     } else {
       $(this).attr("class", "shown");
     };
   },

   hideDeleted: function(){
     $('.deleted').attr("class", Xylotone.deletedView);
     Xylotone.deletedView = "hidden";
  },

  showDeleted: function(){
    $('.hidden').attr("class", "deleted");
     Xylotone.deletedView = "deleted";
  },

  saveImage: function() {
    var $self = $(this),
        deletedIds = [];

   $('.deleted, .hidden').each(function(index, el) {
      deletedIds.push($(el).data('id'))
    });

    $.ajax({
      type: $self.attr('method'),
      url: $self.attr('href'),
      dataType: 'json',
      data: { deleted_ids: deletedIds },

      success: function(data, status, xhr) {
        $self.trigger('ajax:success', [data, status, xhr]);
      },
      error: function(xhr, status, error) {
        $self.trigger('ajax:error', [xhr, status, error]);
      },
      complete: function(xhr, status) {
        $self.trigger('ajax:complete', [xhr, status]);
      }

    });
  },

  deleteDots: function(event, data) {
    $('.hidden, .deleted').hide();
  }

};

$(document).ready(function(){ Xylotone.init(); });
