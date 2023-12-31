//
// js/filer-input.js
//

$(document).ready(function() {       

    const csrftoken = document.querySelector('[name=csrfmiddlewaretoken]').value;

    $('#filer_input').filer({
        limit: 10,
        maxSize: 5242880,
        extensions: ['jpg', 'jpeg', 'png'],       
        changeInput: '<div class="jFiler-input-dragDrop hold-photos" style="width: 100%;"><div class="jFiler-input-inner"><div class="jFiler-input-icon"><i class="icon-jfi-cloud-up-o"></i></div><div class="jFiler-input-text"><h3>Arraste at&eacute; 5 fotos da sua Moto</h3> <p>somente arquivos (jpg ou png)</p></div><a class="jFiler-input-choose-btn blue">Selecione as imagens</a></div></div>',
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
            data: {'csrfmiddlewaretoken': csrftoken},
            type: 'POST',
            enctype: 'multipart/form-data',
            headers: {'X-CSRFToken': csrftoken},
            synchron: true,
            beforeSend: function(){},
            success: function(data, itemEl, listEl, boxEl, newInputEl, inputEl, id) {  
                let filerKit = inputEl.prop('jFiler');                     
                
                const originalFilename = filerKit.files_list[id].file.name;  
                const bucketUrlFilename = data; 

                ordeningLocalStorage();
                                
                localStorage.setItem(localStorage.length, [originalFilename, bucketUrlFilename]);
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

            const originalFilenameDelete = filerKit.files_list[id].file.name;  

            for (let i = 0; i < localStorage.length; i++) {
                let [originalFilename, bucketUrlFilename] = localStorage.getItem(i).split(',');

                if (originalFilenameDelete === originalFilename) {
                    $.ajax({
                        url: IMG_UPLOAD_URL,
                        type: 'DELETE',
                        async: false,
                        cache: false,
                        headers: {'X-CSRFToken': csrftoken},
                        data : {
                            'filename': bucketUrlFilename,
                            'csrfmiddlewaretoken': csrftoken
                        },
                        success: function() {
                           localStorage.removeItem(i);
                        }
                    });

                    ordeningLocalStorage();
                    break;
                }
            }                        
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