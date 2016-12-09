/**
 * Created by samueljaggi on 09.12.16.
 */

$(function(){

    $(window).bind("resize",function(){
        console.log($(this).width())
        if($(this).width() <751){
            $('[class^="choice"]').removeClass('choice-1 choice-2 choice-3 choice-4').addClass('choice-small')
        }
        else{
            $('[class^="choice"]').removeClass('choice-small').addClass('choice-1 choice-2 choice-3 choice-4')
        }
    })
})