//
// js/motorcycle-state-city.js
//

function getMotorcycleBrand(selectId, brandId) {
    return $.ajax({
        url: `${MOTANDO_URL_PREFIX}/api/motorcycles/brands`,
        type: 'GET', 
        dataType: 'json', 
        contentType: 'application/json; charset=utf-8',                         
        beforeSend: function() {          
            $(`#${selectId}`).prop('disabled', true); 
            $(`#${selectId}`).empty();
            $(`#${selectId}`).append('<option value="" id="id_option_motorcycle_brand_empty">Carregando...</option>');          
        },       
        success: function(jsonResp) {
            $('#id_option_motorcycle_brand_empty').attr('value', '').html('Todas as Marcas');
            
            if (jsonResp.status === 'success') {                                           
                jsonResp.data.forEach(brand => {
                    if (brand.id === brandId) 
                       $(`#${selectId}`).append(`<option value="${brand.id}" selected>${brand.brand}</option>`);                
                    else 
                       $(`#${selectId}`).append(`<option value="${brand.id}">${brand.brand}</option>`);  
                });
                
                $(`#${selectId}`).prop('disabled', false);
            }
        },
        error: function(xhr, textStatus, errorThrown) {
            $('#id_motorcycle_brand').prop('disabled', true); 
            $('#id_motorcycle_brand').empty(); 
            $('#id_motorcycle_brand').append('<option value="" id="id_option_motorcycle_brand_empty">Selecione a Marca</option>');  

            console.error(textStatus);
        }
    });
}

function getMotorcycleBrandModel(selectId, brandId, modelId) {
    return $.ajax({
        url: `${MOTANDO_URL_PREFIX}/api/motorcycles/brands/${brandId}/models`,
        type: 'GET', 
        dataType: 'json', 
        contentType: 'application/json; charset=utf-8',      
        beforeSend: function() {
            $(`#${selectId}`).prop('disabled', true); 
            $(`#${selectId}`).empty();
            $(`#${selectId}`).append('<option value="" id="id_option_motorcycle_brand_model_empty">Carregando...</option>');      
        },      
        success: function(jsonResp) {
            $('#id_option_motorcycle_brand_model_empty').attr('value', '').html('Todos os Modelos');
                              
            if (jsonResp.status === 'success') {
                jsonResp.data.forEach(model => {
                    if (model.id === modelId)
                        $(`#${selectId}`).append(`<option value="${model.id}" selected>${model.model}</option>`);
                    else
                        $(`#${selectId}`).append(`<option value="${model.id}">${model.model}</option>`);
                });
            }           

            $(`#${selectId}`).prop('disabled', false);   
        },
        error: function(xhr, textStatus, errorThrown) {
            $('#id_motorcycle_brand_model').prop('disabled', true); 
            $('#id_motorcycle_brand_model').empty(); 
            $('#id_motorcycle_brand_model').append('<option value="" id="id_option_motorcycle_brand_model_empty">Selecione o Modelo</option>');  

            console.error(textStatus);            
        }        
    });   
}

function getMotorcycleBrandModelVersion(selectId, brandId, modelId, versionId) {
    return $.ajax({
        url: `${MOTANDO_URL_PREFIX}/api/motorcycles/brands/${brandId}/models/${modelId}/versions`,
        type: 'GET', 
        dataType: 'json', 
        contentType: 'application/json; charset=utf-8',    
        beforeSend: function() {
            $(`#${selectId}`).prop('disabled', true); 
            $(`#${selectId}`).empty();
            $(`#${selectId}`).append('<option value="" id="id_option_motorcycle_brand_model_version_empty">Carregando...</option>');            
        },      
        success: function(jsonResp) {
            $('#id_option_motorcycle_brand_model_version_empty').attr('value', '').html('Todas as Versões');
            
            if (jsonResp.status === 'success') {
                jsonResp.data.forEach(version => {
                    if (version.id === versionId) 
                       $(`#${selectId}`).append(`<option value="${version.id}" selected>${version.version}</option>`);                
                    else 
                       $(`#${selectId}`).append(`<option value="${version.id}">${version.version}</option>`);
                });
            }

            $(`#${selectId}`).prop('disabled', false);        
        },
        error: function(xhr, textStatus, errorThrown) {
            $(`#${selectId}`).prop('disabled', true); 
            $(`#${selectId}`).empty(); 
            $(`#${selectId}`).append('<option value="" id="id_option_motorcycle_brand_model_version_empty">Selecione a Versão</option>');  

            console.error(textStatus);
        }        
    });   
}

function getBrazilState(selectId, stateId) {
    return $.ajax({
      url: `${MOTANDO_URL_PREFIX}/api/brazil/states`,
      type: 'GET', 
      dataType: 'json', 
      contentType: 'application/json; charset=utf-8',    
      beforeSend: function() {
          $(`#${selectId}`).prop('disabled', true); 
          $(`#${selectId}`).empty();
          $(`#${selectId}`).append('<option value="" id="id_option_brazil_state_empty">Carregando...</option>');            
      },      
      success: function(jsonResp) {
          $('#id_option_brazil_state_empty').attr('value', '').html('Todos os Estados');

          if (jsonResp.status === 'success') {
              jsonResp.data.forEach(state => {
                 if (state.id === stateId) 
                    $(`#${selectId}`).append(`<option value="${state.id}" selected>${state.state} (${state.acronym})</option>`);                
                 else 
                   $(`#${selectId}`).append(`<option value="${state.id}">${state.state} (${state.acronym})</option>`);    
              });
          }        

          $(`#${selectId}`).prop('disabled', false); 
      },
      error: function(xhr, textStatus, errorThrown) {
          $(`#${selectId}`).prop('disabled', true); 
          $(`#${selectId}`).empty(); 
          $(`#${selectId}`).append('<option value="" id="id_option_brazil_state_empty">Selecione o Estado</option>');  

          console.error(textStatus);
      }        
  });   
}

function getBrazilStateCity(selectId, stateId, cityId) {
    return $.ajax({
      url: `${MOTANDO_URL_PREFIX}/api/brazil/states/${stateId}/cities`,
      type: 'GET', 
      dataType: 'json', 
      contentType: 'application/json; charset=utf-8', 
      beforeSend: function() {
          $(`#${selectId}`).prop('disabled', true); 
          $(`#${selectId}`).empty();
          $(`#${selectId}`).append('<option value="" id="id_option_brazil_state_city_empty">Carregando...</option>');            
      },      
      success: function(jsonResp) {
          $('#id_option_brazil_state_city_empty').attr('value', '').html('Todas as Cidades');

          if (jsonResp.status === 'success') {
             jsonResp.data.forEach(city => {
                if (city.id === cityId)                 
                   $(`#${selectId}`).append(`<option value="${city.id}" selected>${city.city}</option>`);
                else 
                   $(`#${selectId}`).append(`<option value="${city.id}">${city.city}</option>`);
             });
          }
          
          $(`#${selectId}`).prop('disabled', false);           
      },
      error: function(xhr, textStatus, errorThrown) {
          $(`#${selectId}`).prop('disabled', true); 
          $(`#${selectId}`).empty(); 
          $(`#${selectId}`).append('<option value="" id="id_option_brazil_state_city_empty">Selecione a Cidade</option>');  

          console.error(textStatus);
      }        
  });   
}