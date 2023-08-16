//
// js/main-page.js
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

const urlWithParams = new URL(`${API_CLASSIFIEDAD_SEARCH_URL}`);

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
}

function stateCityParams() {
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
}

$(document).ready(function() {        
    getMotorcycleBrand('id_brand');
    getBrazilState('id_brazil_state');   

    var [brandId, modelId, stateId] = [0, 0, 0];

    $('#id_brand').on('change', function() {        
        brandId = this.value;
     
        if (brandId > 0) {            
            getMotorcycleBrandModel('id_model', brandId); 
            brandModelParams(); 
        }           
        else {
            $('#id_model').prop('disabled', true); 
            $('#id_model').empty();
            $('#id_model').append('<option value="" id="id_option_motorcycle_brand_model_version_empty">Selecione o Modelo</option>');            
        }
    });  
   
    $('#id_model').on('change', function() {        
        modelId = this.value;        
        
        if (modelId) {
            getMotorcycleBrandModelVersion('id_model_version', brandId, modelId);
            brandModelParams();
        }
        else {
            $('#id_model_version').prop('disabled', true); 
            $('#id_model_version').empty();
            $('#id_model_version').append('<option value="" id="id_option_motorcycle_brand_model_version_empty">Selecione a Versão</option>'); 
        }
    });

    $('#id_model_version').on('change', function() {        
        modelId = this.value;

        if (brandId && modelId) {
            getMotorcycleBrandModelVersion(brandId, modelId); 
        }           
        else {
            $('#id_model_version').prop('disabled', true); 
            $('#id_model_version').empty();
            $('#id_model_version').append('<option value="" id="id_option_motorcycle_model_version_empty">Selecione a Versão</option>');            
        }
    });  
    
    $('#id_brazil_state').on('change', function() {  
        stateId = this.value;
        
        if (stateId) {
            getBrazilStateCity('id_brazil_state_city', stateId); 
            stateCityParams();
        }           
        else {
            $('#id_brazil_state_city').prop('disabled', true); 
            $('#id_brazil_state_city').empty();
            $('#id_brazil_state_city').append('<option value="" id="id_option_brazil_state_city_empty">Selecione a Cidade</option>');            
        }
    });  

    $('#id_owl_carousel_top_deals').owlCarousel({        
        loop:true,
        responsiveClass:true,
        margin:10,
        nav:true,
        responsive:{
            0:{
                items:1
            },
            600:{
                items:3
            },
            1000:{
                items:5
            }
        }
    });

    $('#id_owl_carousel_news').owlCarousel({        
        loop:false,
        margin:10,
        items:1,
        nav: true,
        autoWidth:true,
        responsiveClass:true
    });

    $('#id_form').on('submit', function(e) {   
        const url = urlWithParams.toString();
        const q = url.substring(url.indexOf('?') + 1);        
        $('#id_search_url').val(q);   
    });

});