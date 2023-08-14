//
// js/classifiedad-all.js
//

const urlParamsKeyValue = {
    'model__brand__brand': null, 
    'model__model': null,
    'user__user__state': null,
    'user__user__city': null,
    'color': null,
    'brake_system': null,
    'ignition_system': null,
    'is_new': null,
    'doc_ok': null,
    'accept_exchange': null,
    'accept_new_offer': null
};

const urlWithParams = new URL('http://127.0.0.1:8000/api/classifiedads/all');

function ajaxGetRequest() {   
    return $.ajax({
        url: urlWithParams.toString(),
        type: 'GET', 
        dataType: 'json', 
        contentType: 'application/json; charset=utf-8',                      
        beforeSend: function() {            
            $.blockUI({ 
                message: '<h2>Por favor aguarde ...</h2>',
                overlayCSS: { backgroundColor: '#dee2e6' } 
            });          
        },
        complete: function() {    
            $.unblockUI();             
        },
        success: function(data) { 
            return data;
        },
        error: function(xhr, textStatus, errorThrown) {                    
            console.log(textStatus);            
        }
    });    
}

function brandModelParams() {
    let brandName = null;
    let brandId = null;
    let brandModelName = null;
    let branModelId = null;

    brandId = $('#id_brand').find(':selected').val();
    branModelId = $('#id_model').find(':selected').val();

    if (brandId) {
        brandName = $('#id_brand').find(':selected').text();
        brandId = $('#id_brand').find(':selected').val();

        urlWithParams.searchParams.delete('model__brand__brand');
        urlWithParams.searchParams.append('model__brand__brand', encodeURIComponent(brandName));
        
        urlWithParams.searchParams.delete('model__model');        
    }        
    else {
        urlWithParams.searchParams.delete('model__model');
    }        

    if (branModelId) {
        brandModelName = $('#id_model').find(':selected').text();

        urlWithParams.searchParams.delete('model__model'); 
        urlWithParams.searchParams.append('model__model', encodeURIComponent(brandModelName)); 
    }
    else {
        urlWithParams.searchParams.delete('model__model');        
    } 

    ajaxGetRequest();
}

function stateCity() {
    let stateId = null;
    let cityId = null;

    stateId = $('#id_brazil_state').find(':selected').val();
    cityId = $('#id_brazil_state_city').find(':selected').val();
    
    if (stateId) {
        urlWithParams.searchParams.delete('user__user__state');
        urlWithParams.searchParams.append('user__user__state', encodeURIComponent(stateId));
        
        urlWithParams.searchParams.delete('user__user__city');        
    }        
    else {
        urlWithParams.searchParams.delete('user__user__city');
    }   

    if (cityId) {
        urlWithParams.searchParams.delete('user__user__city'); 
        urlWithParams.searchParams.append('user__user__city', encodeURIComponent(cityId)); 
    }
    else {
        urlWithParams.searchParams.delete('user__user__city');        
    } 

    ajaxGetRequest();
}

function colorBrakeIgnition() {    
    let colorId = null;
    let brakeSystemId = null;
    let ignitionSystemId = null;
    
    colorId = $('#id_motorcycle_color').find(':selected').val();

    if (colorId) {        
        urlWithParams.searchParams.delete('color');
        urlWithParams.searchParams.append('color', encodeURIComponent(colorId));        
    }        
    else {
        urlWithParams.searchParams.delete('color');
    }      
    
    brakeSystemId = $('#id_brake_system').find(':selected').val();

    if (brakeSystemId) {        
        urlWithParams.searchParams.delete('brake_system');
        urlWithParams.searchParams.append('brake_system', encodeURIComponent(brakeSystemId));
    }        
    else {
        urlWithParams.searchParams.delete('brake_system');
    }        

    ignitionSystemId = $('#id_ignition_system').find(':selected').val();

    if (ignitionSystemId) {        
        urlWithParams.searchParams.delete('ignition_system');
        urlWithParams.searchParams.append('ignition_system', encodeURIComponent(ignitionSystemId));
    }        
    else {
        urlWithParams.searchParams.delete('ignition_system');
    }   
    
    ajaxGetRequest();
}    

function OtherDetails() {    
    let isNew = null;
    let docOk = null;
    let acceptExchange = null;
    let acceptNewOffer = null;
    
    isNew = $('#id_is_new').is(':checked');
 
    if (isNew) {        
        urlWithParams.searchParams.delete('is_new');
        urlWithParams.searchParams.append('is_new', encodeURIComponent(isNew));        
    }        
    else {
        urlWithParams.searchParams.delete('is_new');
    }      

    docOk = $('#id_doc_ok').is(':checked');
 
    if (docOk) {        
        urlWithParams.searchParams.delete('doc_ok');
        urlWithParams.searchParams.append('doc_ok', encodeURIComponent(docOk));        
    }        
    else {
        urlWithParams.searchParams.delete('doc_ok');
    }      

    acceptExchange = $('#id_accept_exchange').is(':checked');
 
    if (acceptExchange) {        
        urlWithParams.searchParams.delete('accept_exchange');
        urlWithParams.searchParams.append('accept_exchange', encodeURIComponent(acceptExchange));        
    }        
    else {
        urlWithParams.searchParams.delete('accept_exchange');
    }    
    
    acceptNewOffer = $('#id_accept_new_offer').is(':checked');
 
    if (acceptNewOffer) {        
        urlWithParams.searchParams.delete('accept_new_offer');
        urlWithParams.searchParams.append('accept_new_offer', encodeURIComponent(acceptNewOffer));        
    }        
    else {
        urlWithParams.searchParams.delete('accept_new_offer');
    }       
    
    ajaxGetRequest();
}

$(document).ready(function() {          
    getMotorcycleBrand('id_brand');
    getBrazilState('id_brazil_state');   
    
    $('#id_brand').on('change', function() {  
        const brandId = this.value;
        getMotorcycleBrandModel('id_model', brandId);     
        brandModelParams();        
    });

    $('#id_model').on('change', function() {
        brandModelParams();
    });

    $('#id_motorcycle_color').on('change', function() {
        colorBrakeIgnition();
    });

    $('#id_brake_system').on('change', function() {
        colorBrakeIgnition();
    });

    $('#id_ignition_system').on('change', function() {
        colorBrakeIgnition();
    });

    $('#id_brazil_state').on('change', function() {     
        const stateId = this.value;
        getBrazilStateCity('id_brazil_state_city', stateId);   
        stateCity();
    });

    $('#id_brazil_state_city').on('change', function() {
        stateCity();
    });

    $('#id_is_new').on('change', function() {
        OtherDetails();
    });

    $('#id_doc_ok').on('change', function() {
        OtherDetails();
    });

    $('#id_accept_exchange').on('change', function() {
        OtherDetails();
    });   

    $('#id_accept_new_offer').on('change', function() {
        OtherDetails();
    });
});