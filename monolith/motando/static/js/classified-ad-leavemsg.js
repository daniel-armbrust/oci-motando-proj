var CLASSIFIEDAD_MSG = CLASSIFIEDAD_MSG || (function(){
    var _args = {}; 

    return {
        init : function(Args) {
            _args = Args;            
        },
        sendUserMessage : function() {
            /*
            let csrf_value = _args[0];
            let user = _args[1];
            let fullName = _args[2];
            let email = _args[3];
            let telephone = _args[4];
            let message = _args[5];
            */
            
            console.log(_args);

            alert(_args[2]);
            
        }
    };
}());