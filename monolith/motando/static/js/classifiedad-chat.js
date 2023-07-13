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

function getSellingMessages() {    
    const userId = $('#id_user_id').val();
    const chatMsgUrl = `http://127.0.0.1:8001/api/chats/messages/user/to/${userId}`;    

    $.ajax({
        url: chatMsgUrl,
        type: 'GET', 
        dataType: 'json', 
        contentType: 'application/json',       
        beforeSend: function() {                                
            $('#id_ajax_loading').toggleClass('d-none d-block');        
        },
        complete: function () {
            $('#id_ajax_loading').toggleClass('d-block d-none');                                     
        },
        success: function(jsonResp) {         

            $('#id_chat_painel').removeClass('d-none');

            id_chat_history

        },
        error: function(xhr, textStatus, errorThrown) {                    
            console.error(textStatus);
            
            $('#id_modal_title').html('Erro');
            $('#id_modal_message').html('Não foi possível obter menssagen(s)! Tente novamente mais tarde.');
            $('#id_modal').modal('show');
            
            $('#id_fullname').attr('readonly', false);
            $('#id_email').attr('readonly', false);
            $('#id_telephone').attr('readonly', false);
            $('#id_message').attr('readonly', false);
        }
    });    
}

function getBuyingMessages() {
    const userId = $('#id_user_id').val();
    const chatMsgUrl = `http://127.0.0.1:8001/api/chats/messages/user/from/${userId}`;    

    $.ajax({
        url: chatMsgUrl,
        type: 'GET', 
        dataType: 'json', 
        contentType: 'application/json',       
        beforeSend: function() {                                
            $('#id_ajax_loading').toggleClass('d-none d-block');        
        },
        complete: function () {
            $('#id_ajax_loading').toggleClass('d-block d-none');                                     
        },
        success: function(jsonResp) {         
            colose.log(jsonResp);
        },
        error: function(xhr, textStatus, errorThrown) {                   
            console.error(textStatus);

            if (xhr.status == 404) {
                $('#id_modal_title').html('Informação');
                $('#id_modal_message').html('No momento você não possui nenhuma mensagem.');
            }
            else {
                $('#id_modal_title').html('Erro');
                $('#id_modal_message').html('Não foi possível obter as sua(s) menssagen(s)! Tente novamente mais tarde.');
            }
           
            $('#id_modal').modal('show');
            
            $('#id_fullname').attr('readonly', false);
            $('#id_email').attr('readonly', false);
            $('#id_telephone').attr('readonly', false);
            $('#id_message').attr('readonly', false);
        }
    });    
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