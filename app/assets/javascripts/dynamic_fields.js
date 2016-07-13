/**
 * Created by samueljaggi on 13.07.16.
 */

function checkRemove() {
    if ($('div.input-append').length == 1) {
        $('#remove').hide();
    } else {
        $('#remove').show();
    }
};
$(document).ready(function() {
    checkRemove()
    $('#add').click(function() {
        $('div.input-append:last').after($('div.input-append:first').clone());
        checkRemove();
    });
    $('#remove').click(function() {
        $('div.input-append:last').remove();
        checkRemove();
    });
});