var Xylotone = {
    deletedView: 'empty',
    selectOn: 0,

  init: function() {
     Xylotone.selectionBox= $('#selection-box');
     $('circle').on('click', this.toggleDot);
     $('#show').on('click', this.hideDeleted);
     $('#hide').on('click', this.showDeleted);
     $('#xylo-box').on('mousedown', this.startBox);
     $(window).on('mouseup', this.stopBox);
     $('#xylo-box').on('mousemove', this.adjustBox);
     $('#save-image').on('click', this.saveImage);
     $('#save-image').on('ajax:success', this.deleteDots);
   },

  startBox: function(event){
    Xylotone.selectOn = 1;
    console.log(Xylotone.selectOn);
    Xylotone.selectionBox.css('left', event.pageX - $('#xylo-box').offset().left);
    Xylotone.selectionBox.css('top', event.pageY - $('#xylo-box').offset().top);
  },

  stopBox: function(){
    Xylotone.selectOn = 0;
		console.log(Xylotone.selectOn);
    Xylotone.selectionBox.addClass("hidden");
    Xylotone.boxDelete()
    Xylotone.selectionBox.css('width', '1px');
    Xylotone.selectionBox.css('height', '1px');
  },

  boxDelete: function(event){
    var smallX = parseInt(Xylotone.selectionBox.css("left"));
    var smallY = parseInt(Xylotone.selectionBox.css("top"));
    var bigX = parseFloat(Xylotone.selectionBox.width())+ smallX;
    var bigY = parseFloat(Xylotone.selectionBox.height())+ smallY;
    $('circle').each(function() {
      var $dot = $(this)
      var dotX = $dot.attr("cx");
      var dotY = $dot.attr("cy");
    if ( dotX > smallX && dotX < bigX && dotY > smallY && dotY < bigY )
    {
      $dot.attr("class", Xylotone.deletedView);
    };
  });
  },


  adjustBox: function(event){
    if (Xylotone.selectOn == 1)
     {
      Xylotone.selectionBox.removeClass("hidden");
      var newWidth = event.pageX - Xylotone.selectionBox.offset().left;
      var newHeight = event.pageY - Xylotone.selectionBox.offset().top;

      Xylotone.selectionBox.css('width', newWidth + 'px');
      Xylotone.selectionBox.css('height', newHeight + 'px');
     };
  },


  toggleDot: function(){
    if ($(this).hasClass("full")){
      $(this).attr("class", Xylotone.deletedView);
    } else {
      $(this).attr("class", "full");
    };
  },

  hideDeleted: function(){
    $('.deleted').attr("class", "empty");
    Xylotone.deletedView = "empty";
  },

  showDeleted: function(){
    $('.empty').attr("class", "deleted");
     Xylotone.deletedView = "deleted";
  },

  saveImage: function() {
    var $self = $(this),
        deletedIds = [];

   $('.deleted, .empty').each(function(index, el) {
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
    $('.empty, .deleted').hide();
  }

};

$(document).ready(function(){ window.setInterval(Xylotone.init(), 100); });
