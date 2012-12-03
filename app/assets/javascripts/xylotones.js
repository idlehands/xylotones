window.deleted_view = "hidden"

$(document).ready(function(){
    $('circle').click(function(){
        if($(this).hasClass("shown")){
            $(this).attr("class", window.deleted_view);
        }
        else{
            $(this).attr("class", "shown");
        }
    })
});

$(document).ready(function(){
    $('#show').click(function(){
        $('.deleted').attr("class", "hidden");
        window.deleted_view = "hidden";
    })
});

$(document).ready(function(){
    $('#hide').click(function(){
        $('.hidden').attr("class", "deleted");
        window.deleted_view = "deleted";
    })
});