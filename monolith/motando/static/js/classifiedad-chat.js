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
            const userToEmail = _args[4];  
            const classifiedadId = _args[5];  
            const chatMsgUrl = _args[6];   
            
            const jsonData = JSON.stringify({     
                fullname_from: userFromFullname,                                                    
                email_from: userFromEmail,
                telephone_from: userFromTelephone,
                email_to: userToEmail,
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
                    $('#id_meus_anuncios').html('');
                    $('#id_full_name').attr('readonly', true);
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
                    
                    $('#id_full_name').attr('readonly', false);
                    $('#id_full_name').val('');
                    
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
                    
                    $('#id_full_name').attr('readonly', false);
                    $('#id_email').attr('readonly', false);
                    $('#id_telephone').attr('readonly', false);
                    $('#id_message').attr('readonly', false);
                }
            });
        }
    };
}());