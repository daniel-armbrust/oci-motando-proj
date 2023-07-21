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
                fullname_from: userFromFullname,                                                    
                email_from: userFromEmail,
                telephone_from: userFromTelephone,               
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

function buildChatPanel(jsonResp) {
    let [htmlChatHistory, htmlChatMessages, chatDateTime, chatDateTimeStr] = ['', '', '', ''];
    let [price, brPrice] = [0, 0];   

    if (jsonResp.status === 'success') {
        $('#id_chat_painel').removeClass('d-none');

        for (let idxData = 0 ; idxData < jsonResp.data.length ; idxData++) {
            price = parseFloat(jsonResp.data[idxData].price);
            brPrice = price.toLocaleString('pt-br', {style: 'currency', currency: 'BRL'});

            htmlChatHistory = `
               <div class="row"><div class="col m-2">
                   <a href="#" class="text-decoration-none">
                     <p class="fst-italic">${jsonResp.data[idxData].user_from_fullname}</p>
                     <p><span class="fw-bolder fst-italic">Anúncio:</span> 
                        ${jsonResp.data[idxData].motorcycle} - ${brPrice}
                     </p></a><hr></div></div>`;
            
            $('#id_chat_history').append(htmlChatHistory);
            $('#id_chat_from_fullname').html(jsonResp.data[idxData].user_from_fullname);

            for (let idxMessages = 0 ; idxMessages < jsonResp.data[idxData].messages.length ; idxMessages++) {
                chatDateTime = new Date(jsonResp.data[idxData].messages[idxMessages].timestamp);
                chatDateTimeStr = `${chatDateTime.toLocaleDateString()} - ${chatDateTime.toLocaleTimeString('pt-BR')}`;

                htmlChatMessages = `
                    <div class="row"><div class="col">
                        <div style="background-color: #C6C6C6;" class="p-3 border rounded">
                           <p class="fw-bold fst-italic">
                               ${jsonResp.data[idxData].messages[idxMessages].from}
                               <span class="text-right small">(${chatDateTimeStr})</span>
                           </p><p class="fst-italic">${jsonResp.data[idxData].messages[idxMessages].text}</p>
                    </div></div></div><br>`;

                $('#id_chat_messages').append(htmlChatMessages);
            }
        }         
    }
    else {
        $('#id_modal_title').html('Informação');
        $('#id_modal_message').html('No momento você não possui nenhuma mensagem.');        
        $('#id_modal').modal('show');
    }
}

function getSellingMessages() {    
    const data = ajaxGetRequest(SELLING_URL);
    const jsonResp = data.responseJSON;    
   
    $('#id_chat_painel').addClass('d-none'); 
    $('#id_chat_history').empty(); 
    $('#id_chat_messages').empty();     

    buildChatPanel(jsonResp);
}

function getBuyingMessages() {    
    const data = ajaxGetRequest(BUYING_URL);
    const jsonResp = data.responseJSON;    

    $('#id_chat_painel').addClass('d-none'); 
    $('#id_chat_history').empty(); 
    $('#id_chat_messages').empty();     

    buildChatPanel(jsonResp);  
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