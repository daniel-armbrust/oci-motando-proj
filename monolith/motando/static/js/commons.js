//
// js/commons.js
//

function getMotorcycleBrand(selectId, brandId) {

    return $.ajax({
        url: '/api/moto/marca',
        type: 'GET', 
        dataType: 'json',            
        beforeSend: function() {          

            $(`#${selectId}`).prop('disabled', true); 
            $(`#${selectId}`).empty();
            $(`#${selectId}`).append('<option value="" id="id_option_motorcycle_brand_empty">Carregando...</option>');          

        },       
        success: function(jsonResp) {

            $('#id_option_motorcycle_brand_empty').attr('value', '').html('Todas as Marcas');
                              
            jsonResp.map((brand) => {

                if (brand.id === brandId) 
                    $(`#${selectId}`).append(`<option value="${brand.id}" selected>${brand.brand}</option>`);                
                else 
                    $(`#${selectId}`).append(`<option value="${brand.id}">${brand.brand}</option>`);    
                                
            });

            $(`#${selectId}`).prop('disabled', false);

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
        url: `/api/moto/marca/${brandId}/modelo`,
        type: 'GET', 
        dataType: 'json',    
        beforeSend: function() {

            $(`#${selectId}`).prop('disabled', true); 
            $(`#${selectId}`).empty();
            $(`#${selectId}`).append('<option value="" id="id_option_motorcycle_brand_model_empty">Carregando...</option>');      

        },      
        success: function(jsonResp) {

            $('#id_option_motorcycle_brand_model_empty').attr('value', '').html('Todos os Modelos');
                              
            jsonResp.map((model) => {
                if (model.id === modelId)
                    $(`#${selectId}`).append(`<option value="${model.id}" selected>${model.model}</option>`);
                else
                    $(`#${selectId}`).append(`<option value="${model.id}">${model.model}</option>`);
            });

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
        url: `/api/moto/marca/${brandId}/modelo/${modelId}/versao`,
        type: 'GET', 
        dataType: 'json',    

        beforeSend: function() {

            $(`#${selectId}`).prop('disabled', true); 
            $(`#${selectId}`).empty();
            $(`#${selectId}`).append('<option value="" id="id_option_motorcycle_brand_model_version_empty">Carregando...</option>');            

        },      
        success: function(jsonResp) {

            $('#id_option_motorcycle_brand_model_version_empty').attr('value', '').html('Todas as Versões');
                              
            jsonResp.map((version) => {                
                if (version.id === versionId) 
                   $(`#${selectId}`).append(`<option value="${version.id}" selected>${version.version}</option>`);                
                else 
                   $(`#${selectId}`).append(`<option value="${version.id}">${version.version}</option>`);
            });           

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
      url: '/api/brasil/estado',
      type: 'GET', 
      dataType: 'json',    

      beforeSend: function() {

          $(`#${selectId}`).prop('disabled', true); 
          $(`#${selectId}`).empty();
          $(`#${selectId}`).append('<option value="" id="id_option_brazil_state_empty">Carregando...</option>');            

      },      
      success: function(jsonResp) {

          $('#id_option_brazil_state_empty').attr('value', '').html('Todos os Estados');
                            
          jsonResp.map((state) => {              
              if (state.id === stateId) 
                 $(`#${selectId}`).append(`<option value="${state.id}" selected>${state.state} (${state.acronym})</option>`);                
              else 
                 $(`#${selectId}`).append(`<option value="${state.id}">${state.state} (${state.acronym})</option>`);    
          });

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
      url: `/api/brasil/estado/${stateId}/cidade`,
      type: 'GET', 
      dataType: 'json',    

      beforeSend: function() {

          $(`#${selectId}`).prop('disabled', true); 
          $(`#${selectId}`).empty();
          $(`#${selectId}`).append('<option value="" id="id_option_brazil_state_city_empty">Carregando...</option>');            

      },      
      success: function(jsonResp) {

          $('#id_option_brazil_state_city_empty').attr('value', '').html('Todas as Cidades');
                            
          jsonResp.map((city) => {
            if (city.id === cityId)                 
                $(`#${selectId}`).append(`<option value="${city.id}" selected>${city.city}</option>`);
            else 
                $(`#${selectId}`).append(`<option value="${city.id}">${city.city}</option>`);
          });

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

function selectMotoMarcaModelo(motoMarcaId, motoModeloId) {

    getMotoMarca().then(() => {
        const selectMotoMarca = document.getElementById('id_moto_marca');               

        for (let i = 0 ; i < selectMotoMarca.options.length ; i++) {   
           let selectMotoMarcaValue = selectMotoMarca.options[i].value;

           if (selectMotoMarcaValue === motoMarcaId) {
               selectMotoMarca.options[i].selected = true; 

               getMotoModelo(motoMarcaId).then(() => {
                   const selectMotoModelo = document.getElementById('id_moto_modelo');

                   for (let z = 1 ; z < selectMotoModelo.options.length ; z++) {
                       let selectMotoModeloValue = selectMotoModelo.options[i].value;

                       if (selectMotoModeloValue === motoModeloId) {
                          selectMotoModelo.options[i].selected = true;
                       }
                   }                           
               });               
           }              
        }
    });    
}

function returnBrPreco(preco) {
    const brPreco = preco.toLocaleString('pt-br', {style: 'currency', currency: 'BRL'});
    return brPreco;
}

function ordeningLocalStorage() {
    if (localStorage.length <= 0)
       return;

    let arrTmp = new Array();
    let i = 0;
 
    while (i <= localStorage.length) {
        let item = localStorage.getItem(i);
        
        if (item !== null) 
           arrTmp.push(item);      

        i++;        
    }

    localStorage.clear();
                
    for (let i = 0 ; i < arrTmp.length ; i++)
       localStorage.setItem(i, arrTmp[i]);
}