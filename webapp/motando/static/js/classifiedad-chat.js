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

            if (userFromFullname.length < 8) {
                alert('Por favor, digite um nome válido para prosseguir.');
                return false;
            }
            else if (userFromEmail.length < 10) {
                alert('Por favor, digite um e-mail válido para prosseguir.');
                return false;
            }
            else if (userFromMessage.length < 5) {
                alert('Por favor, digite uma mensagem válida para prosseguir.');
                return false;
            }
            
            const jsonData = JSON.stringify({     
                fullname_from: userFromFullname,                                                    
                email_from: userFromEmail,
                telephone_from: userFromTelephone,               
                classifiedad_id: classifiedadId,
                message: userFromMessage                
            });

            const csrftoken = document.querySelector('[name=csrfmiddlewaretoken]').value;

            $.ajax({
                url: chatMsgUrl,
                type: 'POST', 
                dataType: 'json', 
                contentType: 'application/json', 
                headers: {'X-CSRFToken': csrftoken},
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
                    
                    if (ANONYMOUS_USER) {
                        $('#id_fullname').val('');
                        $('#id_email').val('');
                        $('#id_telephone').val('');
                        
                        $('#id_fullname').attr('readonly', false);
                        $('#id_email').attr('readonly', false);
                        $('#id_telephone').attr('readonly', false);
                    }
                    
                    $('#id_message').val('');                   
                    $('#id_message').attr('readonly', false);                       
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
        },
        complete: function() {           
        },
        success: function(data) { 
            return data;
        },
        error: function(xhr, textStatus, errorThrown) {                    
            console.log(textStatus);            
        }
    });
}

function sendChatMessage() { 
    const chatId = $('#id_chat_id').val();
    const url = `/api/chats/${chatId}/messages`;
    const csrftoken = document.querySelector('[name=csrfmiddlewaretoken]').value;

    const jsonData = JSON.stringify({
         message: $('#id_chat_message').val(),
         chat_id: chatId
    });

    $.ajax({
        url: url,
        type: 'POST', 
        dataType: 'json', 
        headers: {'X-CSRFToken': csrftoken},
        data: jsonData,
        contentType: 'application/json',                      
        beforeSend: function() {                      
            $('#id_button_sendmsg').attr('disabled', true);
            $('#id_chat_message').attr('readonly', true);
        },
        complete: function() { 
            $('#id_button_sendmsg').attr('disabled', false);
            $('#id_chat_message').attr('readonly', false);                      
        },
        success: function(data) { 
            if (data.status === 'success') {
                $('#id_modal_title').html('SUCESSO');
                $('#id_modal_message').html('A sua mensagem foi enviada com sucesso!');        
                $('#id_modal').modal('show'); 

                $('#id_chat_message').val('');
            }
            else {
                $('#id_modal_title').html('ERRO');
                $('#id_modal_message').html('Não foi possível enviar a sua mensagen! Tente novamente mais tarde.');        
                $('#id_modal').modal('show');    
            }
        },
        error: function(xhr, textStatus, errorThrown) {  
            $('#id_modal_title').html('ERRO');
            $('#id_modal_message').html('Não foi possível enviar a sua mensagen! Tente novamente mais tarde.');            
            $('#id_modal').modal('show');    

            console.log(textStatus);            
        }
    });
}

function buildChatPanel(participantsJson, messagesJson, chatType) {
    let [htmlChatHistory, htmlChatMessages, chatDateTime, chatDateTimeStr] = ['', '', '', ''];
    let [price, brPrice] = [0, 0];   

    if (participantsJson.status === 'success' && messagesJson.status === 'success') {
        $('#id_chat_painel').removeClass('d-none');
      
        let participantFullname = null;
        let participantEmail = null;
        let participantNameEmail = null;

        // Participants (Left Panel) 
        for (let i = 0; i < participantsJson.data.length ; i++) {
            price = parseFloat(messagesJson.data[0].price);
            brPrice = price.toLocaleString('pt-br', {style: 'currency', currency: 'BRL'});

            if (chatType === 'selling') {
                participantFullname = participantsJson.data[i].user_from_fullname;
                participantEmail = participantsJson.data[i].user_from_email;
            }
            else {
                participantFullname = participantsJson.data[i].user_to_fullname;
                participantEmail = participantsJson.data[i].user_to_email;
            }            
           
            if (participantFullname !== null)
                participantNameEmail = participantFullname;
            else
                participantNameEmail = participantEmail;
                
            htmlChatHistory = `
               <div class="row"><div class="col m-2">
                   <a href="javascript:void(0);" onclick="getChatMessages('${chatType}', ${participantsJson.data[i].id});" 
                      class="text-decoration-none">
                     <p class="fst-italic">${participantNameEmail}</p>
                     <p><span class="fw-bolder fst-italic">Anúncio:</span> 
                        ${messagesJson.data[0].motorcycle} - ${brPrice}
                     </p></a><hr></div></div>`;
            
            $('#id_chat_history').append(htmlChatHistory);
            $('#id_chat_from_fullname').html(participantNameEmail);          
        }

        // Messages (Right Panel)
        for (let i = 0 ; i < messagesJson.data[0].messages.length ; i++) {
            chatDateTime = new Date(messagesJson.data[0].messages[i].timestamp);
            chatDateTimeStr = `${chatDateTime.toLocaleDateString()} - ${chatDateTime.toLocaleTimeString('pt-BR')}`;

            htmlChatMessages = `
                    <div class="row"><div class="col">
                        <div style="background-color: #C6C6C6;" class="p-3 border rounded">
                           <p class="fw-bold fst-italic">
                               ${messagesJson.data[0].messages[i].from}
                               <span class="text-right small">(${chatDateTimeStr})</span>
                           </p><p class="fst-italic">${messagesJson.data[0].messages[i].text}</p>
                    </div></div></div><br>`;

            $('#id_chat_messages').append(htmlChatMessages);
        }

        $('#id_chat_id').val(messagesJson.data[0].id);
       
        if (messagesJson.data[0].user_from === null) {
            $('#id_button_sendmsg').attr('disabled', true);
            $('#id_chat_message').attr('readonly', true);
        }   
        else {
            $('#id_button_sendmsg').attr('disabled', false);
            $('#id_chat_message').attr('readonly', false);
        }
    }
    else {
        $('#id_modal_title').html('Informação');
        $('#id_modal_message').html('No momento você não possui nenhuma mensagem.');        
        $('#id_modal').modal('show');
    }
}

function getChatMessages(chatType, chatId) {
    let participantsData = null;
    let messagesUrl = null;

    $.blockUI({ 
        message: '<h2>Por favor aguarde ...</h2>',
        overlayCSS: { backgroundColor: '#dee2e6' } 
    });

    $('#id_chat_painel').addClass('d-none'); 
    $('#id_chat_history').empty(); 
    $('#id_chat_messages').empty();

    if (chatType === 'selling')
        participantsData = ajaxGetRequest(SELLING_PARTICIPANTS_URL);    
    else 
        participantsData = ajaxGetRequest(BUYING_PARTICIPANTS_URL);

    const participantsJsonResp = participantsData.responseJSON;    
    
    if (participantsJsonResp.status === 'success') {        
        if (! chatId && chatType === 'selling') {
            chatId = participantsJsonResp.data[0].id; 
            messagesUrl = `/api/chats/${chatId}/messages/selling`;
        }
        else if (chatType === 'selling') {
            messagesUrl = `/api/chats/${chatId}/messages/selling`;
        }
        else if (! chatId && chatType === 'buying') {
            chatId = participantsJsonResp.data[0].id; 
            messagesUrl = `/api/chats/${chatId}/messages/buying`;
        }
        else if (chatType === 'buying') {
            messagesUrl = `/api/chats/${chatId}/messages/buying`;
        }       

        const messagesData = ajaxGetRequest(messagesUrl);
        const messagesJsonResp = messagesData.responseJSON;  
        
        if (messagesJsonResp) {
            buildChatPanel(participantsJsonResp, messagesJsonResp, chatType);
        }
        else {
            $('#id_modal_title').html('ERRO');
            $('#id_modal_message').html('Não foi possível recuperar suas mensagen(s)! Tente novamente mais tarde.');        
            $('#id_modal').modal('show');    
        }
    }
    else {
        $('#id_modal_title').html('Informação');
        $('#id_modal_message').html('Você não possui mensagen(s).');        
        $('#id_modal').modal('show');    
    }

    $.unblockUI();        
}

$(document).ready(function() {              
    $('#id_form_id input[name=chat_options]').on('change', function() {        
       let chatOption = $("#id_form_id input[type='radio']:checked").val();

       getChatMessages(chatOption);       
    });    
    
    $('#id_button_sendmsg').click(function() {
        let chatOption = $("#id_form_id input[type='radio']:checked").val();

        sendChatMessage();
        getChatMessages(chatOption);            
          
        $("#id_chat_messages").scrollTop($('#id_chat_messages')[0].scrollHeight);
    });
});  