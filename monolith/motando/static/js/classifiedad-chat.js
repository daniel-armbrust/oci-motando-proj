var CLASSIFIEDAD_MSG = CLASSIFIEDAD_MSG || (function(){
    var _args = {}; 

    return {
        init : function(Args) {
            _args = Args;            
        },
        sendUserMessage : function() {             
            const userFromFullname = _args[0];           
            const userFromEmail = _args[1];
            const userFromTelephone = _args[2];
            const userFromMessage = _args[3];            
            const classifiedadId = _args[4];  
            const chatMsgUrl = _args[5];   
            
            const jsonData = JSON.stringify({     
                user_from_fullname: userFromFullname,                                                    
                user_from_email: userFromEmail,
                user_from_telephone: userFromTelephone,               
                classifiedad_id: classifiedadId,
                message: userFromMessage
            });

            $.ajax({
                url: chatMsgUrl,
                type: 'POST', 
                dataType: 'json', 
                contentType: 'application/json',
                data: jsonData,                
                beforeSend: function() {                    
                    $('#id_fullname').attr('readonly', true);
                    $('#id_email').attr('readonly', true);
                    $('#id_telephone').attr('readonly', true);
                    $('#id_message').attr('readonly', true);
                    $('#id_ajax_loading').toggleClass('d-none d-block');        
                },
                complete: function () {
                    $('#id_ajax_loading').toggleClass('d-block d-none');                                     
                },
                success: function(jsonResp) {
                    $('#id_modal_title').html('Sucesso');
                    $('#id_modal_message').html('Sua mensagem foi enviada com sucesso!');
                    $('#id_modal').modal('show');
                    
                    $('#id_fullname').attr('readonly', false);
                    $('#id_fullname').val('');
                    
                    $('#id_email').attr('readonly', false);
                    $('#id_email').val('');
                    
                    $('#id_telephone').attr('readonly', false);
                    $('#id_telephone').val('');

                    $('#id_message').attr('readonly', false);   
                    $('#id_message').val('');                   
                },
                error: function(xhr, textStatus, errorThrown) {                    
                    console.error(textStatus);

                    $('#id_modal_title').html('Erro');
                    $('#id_modal_message').html('Não foi possível enviar a sua mensagem! Tente novamente mais tarde.');
                    $('#id_modal').modal('show');
                    
                    $('#id_fullname').attr('readonly', false);
                    $('#id_email').attr('readonly', false);
                    $('#id_telephone').attr('readonly', false);
                    $('#id_message').attr('readonly', false);
                }
            });
        }
    };
}());

function ajaxGetRequest(url) {           
    return $.ajax({
        url: url,
        type: 'GET', 
        dataType: 'json', 
        contentType: 'application/json; charset=utf-8',              
        async: false,
        beforeSend: function() {            
            $.blockUI({ 
                message: '<h2>Por favor aguarde ...</h2>',
                overlayCSS: { backgroundColor: '#dee2e6' } 
            });
        },
        complete: function() {
            $.unblockUI(); 
        },
        success: function(data) { 
            return data;
        },
        error: function(xhr, textStatus, errorThrown) {                    
            console.error(textStatus);            
        }
    });
}

function getSellingMessages() {    
    const data = ajaxGetRequest(SELLING_URL);
    const jsonResp = data.responseJSON;    

    if (jsonResp.status === 'success') {

    }
    else {
        $('#id_modal_title').html('Informação');
        $('#id_modal_message').html('No momento você não possui nenhuma mensagem.');        
        $('#id_modal').modal('show');
    }    
}

function getBuyingMessages() {    
    const data = ajaxGetRequest(SELLING_URL);
    const jsonResp = data.responseJSON;    

    if (jsonResp.status === 'success') {

    }
    else {
        $('#id_modal_title').html('Informação');
        $('#id_modal_message').html('No momento você não possui nenhuma mensagem.');        
        $('#id_modal').modal('show');
    }    
}

$(document).ready(function() {              
    $('#id_form input[name=chat_options]').on('change', function() {        
       let chatOption = $("#id_form input[type='radio']:checked").val();

       switch(chatOption) {
          case 'selling': 
             getSellingMessages();
             break; 
        
          case 'buying':
            getBuyingMessages();
            break;   
             
          default:
            break;
       }
    });       
});  