//
// js/classifiedad-all.js
//

$(document).ready(function(){
    getMotorcycleBrand('id_brand');
    getBrazilState('id_brazil_state');
    
    $('#id_brand').on('change', function(){        
         let brandId = this.value;

         if (brandId) {
            getMotorcycleBrandModel('id_model', brandId); 
         }           
         else {
            $('#id_model').prop('disabled', true); 
            $('#id_model').empty();
            $('#id_model').append('<option value="">Selecione o Modelo</option>');            
         }
     }); 

     $('#id_brazil_state').change(function() {
        let stateId = $(this).children(':selected').val();
        getBrazilStateCity('id_brazil_state_city', stateId);
     });

     $('#id_model').on('change', function(){

     })
});