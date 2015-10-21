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
            context.application.executeAction("more",context.parameter);
        }
    },
    "tMore":{
        template:"tMoreBody",
        parent:"#main",
        onComplete:function(ele,context){
            //初始化滚动区

            window.myScroll=new IScroll('#more', {scrollY: true, scrollX: false});
            ele.find(".adImage").each(function(item,i){
                new AdImage($(this),3);
            });

        }
    }
};
var actions={
    "main":function(context) {
        return "tBody";
    },
    "more":function(context){
        return "tMore";
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
//    OBJC.executeJs("init",{"backText":"返回","titleText":"更多详情","picList":["http://117.79.239.121/webdav/7cfa6f96-930a-4381-88e8-74e6a2908a17.jpg","http://117.79.239.121/webdav/3236a8b7-1180-46d0-a325-2714bea2a80d.jpg","http://117.79.239.121/webdav/601a8d34-c821-4a44-80db-bffa648eec7c.jpg"]});
////    OBJC.executeJs("init",{"backText":"返回","titleText":"更多详情","picList":["http://117.79.239.121/webdav/9d825a66-93f5-4b4a-8212-af187aad8c18.jpg","http://117.79.239.121/webdav/3b2a9a1d-ba0d-4d59-aa92-7fb168f80388.jpg","http://117.79.239.121/webdav/8a5ab77a-6dce-447c-94a5-e55bab9853ad.jpg","http://117.79.239.121/webdav/30feb57e-c364-42a4-b0c4-344c59885cef.jpg","http://117.79.239.121/webdav/e897bf6d-d74d-4318-a133-71d1c97643bd.jpg","http://117.79.239.121/webdav/ab500dfe-d9f9-4d22-adbd-1278ec147fef.jpg","http://117.79.239.121/webdav/3bd20ecb-ebcd-4c53-8e65-3982fc94d6b6.jpg","http://117.79.239.121/webdav/8d889ae6-69cc-4f69-9162-269e2beeb46e.jpg","http://117.79.239.121/webdav/849a86a7-fd45-4b2d-8674-eea23d4b0897.jpg","http://117.79.239.121/webdav/9a997559-5adb-4dd5-b79a-0d6fecaf3cb7.jpg","http://117.79.239.121/webdav/dfc9dc40-9a01-4835-8944-e6477aab3b51.jpg","http://117.79.239.121/webdav/60418a96-d514-494c-998e-065fef599e07.jpg"]});
//});
