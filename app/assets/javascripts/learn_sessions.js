/**
 * Created by samueljaggi on 09.12.16.
 */

$(function(){

    $(window).bind("resize",function(){
        console.log($(this).width())
        if($(this).width() < 751){
            $('[class^="col-xs-12"]').removeClass('choice-1 choice-2 choice-3 choice-4').addClass('choice-small')
        }
        else{
            $('[class^="col-xs-12"]').removeClass('choice-small').addClass('choice-1 choice-2 choice-3 choice-4')
        }
    })
})