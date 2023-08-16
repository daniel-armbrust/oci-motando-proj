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

const urlWithParams = new URL(`${API_CLASSIFIEDAD_SEARCH_URL}`);

function formatReal(price) {
    price = parseInt(price.replace(/[\D]+/g,''));
    let tmp = price+'';
        
    tmp = tmp.replace(/([0-9]{2})$/g, ",$1");
        
    if (tmp.length > 6)
       tmp = tmp.replace(/([0-9]{3}),([0-9]{2}$)/g, ".$1,$2");

    return tmp;
}

function getPageNum(url) {
    return decodeURIComponent((new RegExp('[?|&]page=' + '([^&;]+?)(&|#|;|$)').exec(url) || [null, ''])[1].replace(/\+/g, '%20')) || null;
}
  
function ajaxGetRequest(url) {   
    if (!url)
       url = urlWithParams.toString();

    $.ajax({
        url: url,
        type: 'GET', 
        dataType: 'json', 
        contentType: 'application/json; charset=utf-8',                      
        beforeSend: function() {            
            $.blockUI({ 
                message: '<h2>Por favor aguarde ...</h2>',
                overlayCSS: { backgroundColor: '#dee2e6' } 
            });          

            $('#id_motorcycle_dashboard').empty();
        },
        complete: function() {    
            $.unblockUI();             
        },
        success: function(data) { 
            const jsonResp = data.results;
            const totalMotorcyclesFound = data.count;               

            const colorMap = {'blue': 'Azul', 'green': 'Verde', 'red': 'Vermelho',
                              'black': 'Preto', 'white': 'Branco', 'silver': 'Prata',
                              'yellow': 'Amarelo', 'purple': 'Roxo'};

            let motorcycleUrl = '';
            let motorcycleHtml = '';    
            let mileage = null; 
            
            if (totalMotorcyclesFound <= 0) {
                motorcycleHtml = '<h2 class="text-dark text-center pt-4 fst-italic">Por enquanto... Não há anúncios para este filtro de consulta!</h2>';           
            }
            else {
                for (let i = 0 ; i < jsonResp.length ; i++) {                    
                    motorcycleUrl = `/classifiedad/${jsonResp[i].brand}/${jsonResp[i].model}/${jsonResp[i].model_year}/${jsonResp[i].id}`;
    
                    motorcycleHtml += `<a href="${motorcycleUrl}" class="text-decoration-none text-dark" target="_blank">` +
                                      '<div class="card shadow"><div class="row no-gutters">' +
                                      `<div class="col-auto"><img src="${jsonResp[i].images[0].url}" class="img-fluid rounded" style="max-width: 18rem;" alt="${jsonResp[i].brand} - ${jsonResp[i].model}"></div>` +
                                      '<div class="col"><div class="card-block">' +
                                      `<h4 class="card-title pt-3">${jsonResp[i].brand} - ${jsonResp[i].model}</h4>` +
                                      `<h5 class="h6 text-uppercase">${jsonResp[i].sales_phrase}</h5>` +
                                      '<hr class="p-1" style="width: 98%;"><p class="h5 pt-2">';
    
                    if (jsonResp[i].accept_exchange)
                        motorcycleHtml += '<i class="fas fa-exchange-alt text-primary"></i><span class="text-primary"> Aceita troca </span>';
                    else
                        motorcycleHtml += '<i class="fas fa-exchange-alt text-dark"></i><span class="text-dark"> Não aceita troca </span>';
                        
                    motorcycleHtml += `</p><p class="h3 fw-bold text-success"> R$ ${formatReal(jsonResp[i].price)} </p><p class="h6 pt-2 pb-3">`;
                    motorcycleHtml += `<i class="far fa-calendar-alt"></i> &nbsp; ${jsonResp[i].fabrication_year}/${jsonResp[i].model_year}`;
                    motorcycleHtml += `&nbsp;&nbsp;&nbsp;&nbsp;<i class="fas fa-fill-drip"></i>&nbsp; ${colorMap[jsonResp[i].color]}<span class="text-capitalize"></span>`;
                    
                    mileage = new Intl.NumberFormat('pt-BR', {maximumSignificantDigits: 3}).format(jsonResp[i].mileage);    

                    motorcycleHtml += `&nbsp;&nbsp;&nbsp;&nbsp;<i class="fas fa-tachometer-alt"></i> &nbsp; ${mileage} KM`;
                    motorcycleHtml += '</p></div></div></div></div></a><br>';                
                }  
            }

            const totalMotorcyclePerPage = 7; 
            const maxPageLinks = 14;
            const nextPagelinksCount = Math.round(totalMotorcyclesFound / totalMotorcyclePerPage);
            const urlParamsCount = Array.from(urlWithParams.searchParams).length;
            const activeLinkNumber = getPageNum(url);

            let nextPagelink = null;           
            let paginationLinks = '';            

            if (urlParamsCount >= 0) 
                nextPagelink = `${urlWithParams.toString()}?page=`;
            else
                nextPagelink = `${urlWithParams.toString()}&page=`;                      
                           
            for (let i = 1 ; i <= nextPagelinksCount ; i++) {
                if (activeLinkNumber == i) {
                   paginationLinks += `<li class="page-item active"><a class="page-link" onclick="ajaxGetRequest('${nextPagelink}${i}');" href="javascript: void(0);">${i}</a></li>`;                    
                }
                else if (i == 1 && activeLinkNumber == null) {                
                   paginationLinks += `<li class="page-item active"><a class="page-link" onclick="ajaxGetRequest('${nextPagelink}${i}');" href="javascript: void(0);">${i}</a></li>`; 
                }
                else {
                   paginationLinks += `<li class="page-item"><a class="page-link" onclick="ajaxGetRequest('${nextPagelink}${i}');" href="javascript: void(0);">${i}</a></li>`; 
                }
            }                    

            motorcycleHtml += '<br><div class="position-relative">' +
                              '<nav style="background-color: #F7F7F7; border-bottom: 0;" class="position-absolute top-0 start-50 translate-middle-x">' +                              
                              '<ul class="pagination">' + paginationLinks + '</ul></nav></div>';                              
                        
            $('#id_motorcycle_dashboard').html(motorcycleHtml);

            document.body.scrollTop = document.documentElement.scrollTop = 0;           
        },
        error: function(xhr, textStatus, errorThrown) {                    
            console.error(textStatus);            
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

    ajaxGetRequest();
}

function colorBrakeIgnitionParams() {    
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

function OtherDetailsParams() {    
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

    if (QUERY_PARAMS) {
        const url = `${API_CLASSIFIEDAD_SEARCH_URL}?${QUERY_PARAMS}`;
        console.log(url);
        ajaxGetRequest(url);
    }
    else {
        ajaxGetRequest();
    }

    $('#id_brand').on('change', function() {  
        const brandId = this.value;

        if (brandId > 0) {
            getMotorcycleBrandModel('id_model', brandId);

            brandModelParams();        
        }
        else {
            $('#id_model').attr('disabled', true);
            $('#id_model').empty();
            $('#id_model').append('<option value="" id="id_option_motorcycle_brand_model_empty" selected="selected">Selecione o Modelo</option>');
            
            getMotorcycleBrand('id_brand');
        }        
    });

    $('#id_model').on('change', function() {
        brandModelParams();
    });

    $('#id_motorcycle_color').on('change', function() {
        colorBrakeIgnitionParams();
    });

    $('#id_brake_system').on('change', function() {
        colorBrakeIgnitionParams();
    });

    $('#id_ignition_system').on('change', function() {
        colorBrakeIgnitionParams();
    });

    $('#id_brazil_state').on('change', function() {     
        const stateId = this.value;
        getBrazilStateCity('id_brazil_state_city', stateId);   
        stateCityParams();
    });

    $('#id_brazil_state_city').on('change', function() {
        stateCityParams();
    });

    $('#id_is_new').on('change', function() {
        OtherDetailsParams();
    });

    $('#id_doc_ok').on('change', function() {
        OtherDetailsParams();
    });

    $('#id_accept_exchange').on('change', function() {
        OtherDetailsParams();
    });   

    $('#id_accept_new_offer').on('change', function() {
        OtherDetailsParams();
    });
});