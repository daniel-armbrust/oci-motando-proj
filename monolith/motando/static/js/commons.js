//
// js/commons.js
//



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