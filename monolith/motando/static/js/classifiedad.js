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

function submitAnuncio() {
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

$(document).ready(function() {           

    $('#id_preco').maskMoney({symbol:'R$ ', thousands:'.', decimal:',', symbolStay: true});

    getMotorcycleBrand('id_motorcycle_brand');

    $('#id_motorcycle_brand_model').empty();
    $('#id_motorcycle_brand_model').append('<option value="">Selecione o Modelo</option>');         

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

    $('#id_is_new').click(function() {
          let isNew = $('#id_is_new').prop('checked');

          if (isNew) {
             $('#id_mileage').prop('readonly', true)
             $('#id_mileage').val(0);
          }                   
          else {
             $('#id_mileage').prop('readonly', false)
             $('#id_mileage').val('');
          }                   
    });    

    const price = parseFloat($('#id_price').val());

    if (price) {
       const brPrice = price.toLocaleString('pt-br', {style: 'currency', currency: 'BRL'});

       $('#id_price').val(brPreco);
    }       

    $('#id_form_classifiedad').submit(function(e) {         
      
        const CLASSIFIEDAD_IMG_LIST = $('#id_classifiedad_images').val();   

        if (CLASSIFIEDAD_IMG_LIST.length <= 0) {
            alert('Seu anúncio necessita de imagen(s) para ser publicado!');
            e.preventDefault();
        }
        else {
            submitAnuncio();                  
        }
    });

    $('#filer_input').filer({
        limit: 10,
        maxSize: 5242880,
        extensions: ['jpg', 'jpeg', 'png'],       
        changeInput: '<div class="jFiler-input-dragDrop hold-photos"><div class="jFiler-input-inner"><div class="jFiler-input-icon"><i class="icon-jfi-cloud-up-o"></i></div><div class="jFiler-input-text"><h3>Arraste at&eacute; 5 fotos da sua Moto</h3> <p>somente arquivos (jpg ou png)</p></div><a class="jFiler-input-choose-btn blue">Selecione as imagens</a></div></div>',
        showThumbs: true,
        theme: 'dragdropbox',
        templates: {
            box: '<ul class="jFiler-items-list jFiler-items-grid"></ul>',
            item: '<li class="jFiler-item">\
                        <div class="jFiler-item-container">\
                            <div class="jFiler-item-inner">\
                                <div class="jFiler-item-thumb">\
                                    <div class="jFiler-item-status"></div>\
                                    <div class="jFiler-item-thumb-overlay">\
                                        <div class="jFiler-item-info">\
                                            <div style="display:table-cell;vertical-align: middle;">\
                                                <span class="jFiler-item-title"><b title="{{fi-name}}">{{fi-name}}</b></span>\
                                                <span class="jFiler-item-others">{{fi-size2}}</span>\
                                            </div>\
                                        </div>\
                                    </div>\
                                    {{fi-image}}\
                                </div>\
                                <div class="jFiler-item-assets jFiler-row">\
                                    <ul class="list-inline pull-left">\
                                        <li>{{fi-progressBar}}</li>\
                                    </ul>\
                                    <ul class="list-inline pull-right">\
                                        <li><a class="icon-jfi-trash jFiler-item-trash-action text-decoration-none"></a></li>\
                                    </ul>\
                                </div>\
                            </div>\
                        </div>\
                    </li>',
            itemAppend: '<li class="jFiler-item">\
                    <div class="jFiler-item-container">\
                        <div class="jFiler-item-inner">\
                            <div class="jFiler-item-thumb">\
                                <div class="jFiler-item-status"></div>\
                                <div class="jFiler-item-thumb-overlay">\
                                    <div class="jFiler-item-info">\
                                        <div style="display:table-cell;vertical-align: middle;">\
                                            <span class="jFiler-item-title"><b title="{{fi-name}}">{{fi-name}}</b></span>\
                                            <span class="jFiler-item-others">{{fi-size2}}</span>\
                                        </div>\
                                    </div>\
                                </div>\
                                {{fi-image}}\
                            </div>\
                            <div class="jFiler-item-assets jFiler-row">\
                                <ul class="list-inline pull-left">\
                                    <li><span class="jFiler-item-others">{{fi-icon}}</span></li>\
                                </ul>\
                                <ul class="list-inline pull-right">\
                                    <li><a class="icon-jfi-trash jFiler-item-trash-action text-decoration-none"></a></li>\
                                </ul>\
                            </div>\
                        </div>\
                    </div>\
                </li>',
            progressBar: '<div class="bar"></div>',
        itemAppendToEnd: false,
        canvasImage: true,
        removeConfirmation: true,
        _selectors: {
                list: '.jFiler-items-list',
                item: '.jFiler-item',
                progressBar: '.bar',
                remove: '.jFiler-item-trash-action'
            }
        },
        dragDrop: {
            dragEnter: null,
            dragLeave: null,
            drop: null,
            dragContainer: null,
        },
        uploadFile: {
            url: IMG_UPLOAD_URL,
            data: null,
            type: 'POST',
            enctype: 'multipart/form-data',
            synchron: true,
            beforeSend: function(){},
            success: function(data, itemEl, listEl, boxEl, newInputEl, inputEl, id) {  
                let filerKit = inputEl.prop('jFiler');                     
                let OriginalFilename = filerKit.files_list[id].file.name;  
                
                addClassifiedadImg(data, OriginalFilename);                                                    
            },
            error: function(el){
                let parent = el.find('.jFiler-jProgressBar').parent();
                
                el.find('.jFiler-jProgressBar').fadeOut('slow', function(){
                    $('<div class="jFiler-item-others text-error"><i class="icon-jfi-minus-circle"></i> Erro</div>').hide().appendTo(parent).fadeIn('slow');
                });
            },
            statusCode: null,
            onProgress: null,
            onComplete: null
        },           
        files: null,            
        addMore: false,
        allowDuplicates: true,
        clipBoardPaste: true,
        excludeName: null,
        beforeRender: null,
        afterRender: null,
        beforeShow: null,
        beforeSelect: null,
        onSelect: null,
        afterShow: null,
        onRemove: function(itemEl, file, id, listEl, boxEl, newInputEl, inputEl) {
            let filerKit = inputEl.prop('jFiler');                     
            let filename = filerKit.files_list[id].file.name;  
            delAnuncioImg(filename);                              
        },
        onEmpty: null,
        options: null,
        dialogs: {
            alert: function(text) {
                return alert(text);
            },
            confirm: function (text, callback) {
                confirm(text) ? callback() : null;
            }
        },
        captions: {
            button: 'Escolha o arquivo',
            feedback: 'Escolha arquivos para upload',
            feedback2: 'Arquivos escolhidos',
            drop: 'Arraste aqui seus arquivos (jpg, png, webp)',
            removeConfirmation: 'Tem certeza de que deseja remover este arquivo?',
            errors: {
                filesLimit: `Somente {{ '{{' }}fi-limit{{ '}}' }} arquivos s&atilde;o permitidos de serem enviados.`,
                filesType: 'Somente imagens s&atilde;o permitidos de serem enviados.',
                filesSize: `{{ '{{' }}fi-name{{ '}}' }} &eacute; muito grande! Fa&ccedil;a o upload de arquivos de at&eacute; {{ '{{' }}fi-maxSize{{ '}}' }} MB.`,
                filesSizeAll: `Arquivo(s) estão grandes demais! Fa&ccedil;a o upload de arquivos de at&eacute; {{ '{{' }}fi-maxSize{{ '}}' }} MB.`
            }                
        }
    });   

});