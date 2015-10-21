var views={
    "tHeader":{
        template:"tHeader",   //模板id
        onComplete:function(ele,context){   //视图加入文档后所执行的回调函数
            ele.find("#btnBack").on("tap",function(e){
                context.application.objcClose(context.application.getObjcDefaultParam());
                e.preventDefault();
            });
        }
    },
    "tBody": {
        template: "tBody",   //模板id
        include:["tHeader"],
        onComplete: function (ele,context) {   //视图加入文档后所执行的回调函数
            //显示更多详情
            context.application.executeAction("sizeTable",context.parameter);
        }
    },
    "tSizeTable":{
        template:"tSizeTable",
        parent:"#main",
        onComplete:function(ele,context){
            ele.find(".adImage").each(function(){
                new AdImage($(this));
            });
        }
    }
};
var actions={
    "main":function(context) {
        return "tBody";
    },
    "sizeTable":function(context){
        if(!context.data.sizePicPath && context.data.sizeTable){
            var array=context.data.sizeTable.split("#");
            for(var i=0;i< array.length;i++){
                array[i]=array[i].split(",");
            }
            context.data.sizeTableArray=array;
        }
        return "tSizeTable";
    }
};
var ctrl={

};
OBJC.ready(function(data){
    document.addEventListener("touchmove",function(e){e.preventDefault();return false},false);
    var app=new Application(actions,views).start("main",data);
});
/**测试*/
//$(function(data){
//    OBJC.executeJs("init",{"backText":"返回","titleText":"尺码表","sizeTable":"尺码,衣长,胸围,下摆,肩宽,袖长,袖口#L,42.5,92,80,39,45,13.5#XL,43.5,96,84,41,46,14","sizePicPath":"","sizeinfodetail":"尺码请参考宝贝下面的尺码表。纯手工测量，不免存在1-3cm误差。"});
//});
