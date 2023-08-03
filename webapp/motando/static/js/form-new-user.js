//
// js/form-new-user.js
//
$(document).ready(function() {
    getBrazilState('id_brazil_state');     
    
    $('#id_brazil_state').change(function() {
        let stateId = $(this).children(':selected').val();

        getBrazilStateCity('id_brazil_state_city', stateId);
    });

    $('#id_telephone').mask('(99) 9999-9999?9').focusout(function (event) {  
        var target, phone, element;  
        
        target = (event.currentTarget) ? event.currentTarget : event.srcElement;                 
        phone = target.value.replace(/\D/g, '');
        
        element = $(target);  
        element.unmask();  

        if(phone.length > 10)
            element.mask('(99) 99999-999?9');  
        else 
            element.mask('(99) 9999-9999?9');                    
    });
});