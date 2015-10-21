window.OBJC={
    config:{
        method: {
            CLOSE: {
                name: "close",//关闭当前窗口
                param: {
                    target: "",
                    parameters: {},
                    level: "self"
                }
            },
            MESSAGE: {
                name: "message",
                param: {
                    target:"",
                    parameters: {},
                    level: "self"
                }
            },
            OPEN: {
                name: "open",//关闭当前窗口
                param: {
                    target: "",
                    parameters: {},
                    level: "child",
                    component: ["navbar"],
                    layout:0
                }
            },
            DATACATCH:{
                name:"dataCatch",           //缓存数据
                param:{
                    target:"key1",          //缓存key值
                    parameters:{"a":"a1"},  //缓存value值
                    level:"get"             //操作 get/set
                }
            }
        }
    },
    callbackCatch:{},
    functionCatch:{},
    getDefaultParam:function(){
        return  {
            target:"",
            parameters: {},
            level: "self",
            component: [],
            layout:"0"

    }
    },
    executeNative:function(action,param,success,before) {
        var _param = {
            action:"",
            randomKey:""
        };
        if (param != undefined) {
            for (var key in param) {
                _param[key] = param[key];
            }
        }
        var command = "http://objc/";
        if (action != undefined) {
            var randomKey = new Date().getTime() + "";
            _param.action = action;
            _param.randomKey = randomKey;
            command += JSON.stringify(_param);
            before && before();
            if (typeof success == "function") {
                this.callbackCatch[randomKey] = success;
            }
//            window.randomKey=randomKey;
//            alert(command);
              console.log(command);
//            setTimeout(function(){window.location.href=command;},0);
        }
    },
    ready:function(fun){
        this.regJs("init",fun);
    },
    regJs:function(funKey,fun){
        this.functionCatch[funKey]=fun;
    },
    executeJs:function(funKey,data){
        if(funKey){
            data=typeof data=="string"? JSON.parse(data):data;
            if(this.functionCatch[funKey]){
                this.functionCatch[funKey](data);
            }
            if(this.callbackCatch[funKey]){
                this.callbackCatch[funKey](data);
                delete this.callbackCatch[funKey];
            }
        }
    }
};

