//
// js/motandoadm.js
//

function editMotorcycle() {
    
    let [motorcycleBrandId, motorcycleModelId, motorcycleModelVersionId] = [0, 0, 0];
    
    motorcycleBrandId = $('select[id="id_motorcycle_brand"]').val();
    motorcycleModelId = $('select[id="id_motorcycle_brand_model"]').val();
    motorcycleModelVersionId = $('select[id="id_motorcycle_brand_model_version"]').val();
    
    if (motorcycleBrandId && motorcycleModelId && motorcycleModelVersionId) {

        let url = `/motandoadm/motorcycle/brand/${motorcycleBrandId}/model/${motorcycleModelId}/version/${motorcycleModelVersionId}`;

        $('#id_edit_motorcycle').attr('href', url);
        $('#id_edit_motorcycle').trigger('click');
    }
    else {
        alert('Deve-se selecionar uma motocicleta para edição!');
    }       
}