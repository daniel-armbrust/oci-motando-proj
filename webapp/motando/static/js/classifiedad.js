//
// js/classifiedad.js
//

function confirmDelAnuncioImg(imgFilename, jfilerIndex) {
    const result = window.confirm('Tem certeza que deseja remover essa imagem do anúncio?');

    if (result) {
        delAnuncioImg(imgFilename);                 

        const divId = `id_jfiler_item_${jfilerIndex}`;

        $(`#${divId}`).remove();
    }                   
}

function addClassifiedadImg(respJsonImgFilename, OriginalFilename) {
    const strImgList = $('#id_img_lista').val();

    let elemts = new Array();
    
    if (strImgList) {        
        elemts = JSON.parse(strImgList);
        elemts.push(respJsonImgFilename.img_filename);       
    }
    else {        
        elemts.push(respJsonImgFilename.img_filename);               
    }

    $('#id_img_lista').val(JSON.stringify(elemts));
}

function delAnuncioImg(imgToDeleteFilename) {
    const strImgList = $('#id_img_lista').val();                

    let newArray = new Array();

    if (strImgList) {
       elemts = strImgList.replace(/\ |\'|\"|\[|\]/g, '').split(','); 

       for (let i = 0 ; i < elemts.length ; i++) {
           let imgServerFilename = elemts[i];          

          if (imgToDeleteFilename === imgServerFilename)
            continue;
          else             
             newArray.push(imgServerFilename);                   
       }      
              
       $('#id_img_lista').val(JSON.stringify(newArray));       
    }
}

function submitClassifiedad() {
    let formHasErrors = false;        

    $.blockUI({ 
        message: '<h2>Por favor aguarde ...</h2>',
        overlayCSS: { backgroundColor: '#dee2e6' } 
    });  

    return true;              
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

function returnBrPrice(price) {
    const brPrice = price.toLocaleString('pt-br', {style: 'currency', currency: 'BRL'});
    return brPrice;
}

function confirmDeleteImage(imgUrlFilenameDelete, jfilerIndex) {
    const result = window.confirm('Tem certeza que deseja remover essa imagem do anúncio?');

    if (result) {
       for (let i = 0 ; i < localStorage.length ; i++) {
          const [originalFilename, imgUrlFilename] = localStorage.getItem(i).split(',');                 

          if (imgUrlFilename === imgUrlFilenameDelete) {
              localStorage.removeItem(i);

              $(`#id_jfiler_item_${jfilerIndex}`).remove();                      
              
              ordeningLocalStorage();               
              break;
          }                      
       }               
    }
 }