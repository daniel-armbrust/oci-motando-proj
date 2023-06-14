//
// js/home.js
//

$(document).ready(function() {    
    
    getMotorcycleBrand('id_motorcycle_brand');
    getBrazilState();   

    var [brandId, modelId, stateId] = [0, 0, 0];

    $('#id_motorcycle_brand').on('change', function() {        
        brandId = this.value;
     
        if (brandId) {            
            getMotorcycleBrandModel('id_motorcycle_brand_model', brandId); 
        }           
        else {
            $('#id_motorcycle_brand_model').prop('disabled', true); 
            $('#id_motorcycle_brand_model').empty();
            $('#id_motorcycle_brand_model').append('<option value="" id="id_option_motorcycle_brand_model_version_empty">Selecione o Modelo</option>');            
        }
    });  
   
    $('#id_motorcycle_brand_model').on('change', function() {        
        modelId = this.value;
        
        if (modelId) {
            getMotorcycleBrandModelVersion('id_motorcycle_brand_model_version', brandId, modelId);
        }
        else {
            $('#id_motorcycle_brand_model_version').prop('disabled', true); 
            $('#id_motorcycle_brand_model_version').empty();
            $('#id_motorcycle_brand_model_version').append('<option value="" id="id_option_motorcycle_brand_model_version_empty">Selecione a Versão</option>'); 
        }

    });

    $('#id_motorcycle_brand_model_version').on('change', function() {        
        modelId = this.value;

        if (brandId && modelId) {
            getMotorcycleBrandModelVersion(brandId, modelId); 
        }           
        else {
            $('#id_motorcycle_brand_model_version').prop('disabled', true); 
            $('#id_motorcycle_brand_model_version').empty();
            $('#id_motorcycle_brand_model_version').append('<option value="" id="id_option_motorcycle_model_version_empty">Selecione a Versão</option>');            
        }
    });  
    
    $('#id_brazil_state').on('change', function() {  
        stateId = this.value;
        
        if (stateId) {
            getBrazilStateCity('id_brazil_state_city', stateId); 
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

});