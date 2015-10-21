var url=new function(){
//    this.root="http://www.xinhuan.mobi";
//    this.root="http://117.79.239.194:8080/nhshop";
    this.root="http://123.57.206.88:8080/nhshop";
    this.huanguang=this.root+"/rest/banner/hg/list";
    this.huanguangProductListPage=this.root+"/static/huanguangProductList.html";
    return this;
};

var views={
    "tBody": {
        template: "tBody",   //模板id
        include: ["tHeader"],
        onComplete: function (ele,context) {   //视图加入文档后所执行的回调函数
            //取欢逛接口数据，然后显示欢逛界面
            context.application.ajaxData(url.huanguang,"get",{},function(data){
                context.application.executeAction("activitySlider",data);
            },null,"data");
        }
    },
    "tHeader":{
        template:"tHeader",   //模板id
        onComplete:function(ele,context){   //视图加入文档后所执行的回调函数
            ele.find("#btnBack").on("tap",function(e){
                context.application.objcClose(context.application.getObjcDefaultParam());
                e.preventDefault();
            });
        }
    },
    "tActivitySlider":{
        template:"tActivitySlider",   //模板id
        parent:"#main",
        onComplete:function(ele,context){   //视图加入文档后所执行的回调函数
            var itemWidth=$("#scrollWrap").width();
            var listWidth=(context.data.list.length)*itemWidth;
            var activityWrap= ele.find(".activityList");
            var activitys=ele.find(".activity");

            var firstNode = activitys[0].cloneNode(true);
            var lastNode = activitys[activitys.length-1].cloneNode(true);
            activityWrap.append(firstNode);
            activityWrap.prepend(lastNode);
            activitys=ele.find(".activity");
            activityWrap.css("width",listWidth+itemWidth*2+"px");
            activitys.css("width",itemWidth+"px");

            activitys.find(".adImage").each(function(){
                new AdImage($(this),0.677);
            });

            var sWrap = document.getElementById('scrollWrap');
            var myTouch = util.toucher(sWrap);
            var cur = 1;
            var move = function(dur){
                dur = dur == undefined ? 450 : dur;
                if(activityWrap[0].style.transform != undefined){
                    activityWrap[0].style.transitionDuration = dur+'ms';
                    activityWrap[0].style.transform = 'translateX(-'+cur*itemWidth+'px) translateZ(0px)';
                }else{
                    activityWrap[0].style.webkitTransitionDuration = dur+'ms';
                    activityWrap[0].style.webkitTransform = 'translateX(-'+cur*itemWidth+'px) translateZ(0px)';
                }
                return dur;
            }
            var swipeFunc = function(swipe,callback){
                if(cur == activitys.length-1 || cur == 0)
                    return;
                if(swipe == 0){//left
                    cur++;
                }else{
                    cur--;
                }
                var d = move();
                (function(c,d){
                    setTimeout(function(){
                        if(c == activitys.length-1){
                            cur= 1;
                            move(0);
                        }else if(c == 0){
                            cur= activitys.length-2;
                            move(0);
                        }
                    },d)
                })(cur,d);
            }
            move(0);
            myTouch.on('swipeLeft',function(e){
                swipeFunc(0);
                return false;
            });
            myTouch.on('swipeRight',function(e){
                swipeFunc(1);
                return false;
            })
            var clickable = {
                x:0,
                y:0,
                able:true
            }
            var getPos = function(e){
                var pos = {};
                var toucher = e.touches.lengh>0?e.touches[0]: e.changedTouches[0];
                if(toucher){
                    pos.x = toucher.clientX;
                    pos.y = toucher.clientY;
                    return pos;
                }
            }
            activitys.find(".ad").on("touchstart",function(e){
                var pos = getPos(e);
                clickable.x = pos.x;
                clickable.y = pos.y;
            });

            activitys.find(".ad").on("touchend",function(e){
                var pos = getPos(e);
                if(Math.abs(pos.x-clickable.x)>5 || Math.abs(pos.y-clickable.y)>5){
                    clickable.able = false;
                }else{
                    clickable.able = true;
                }
            });
            activitys.find(".ad").on("tap",function(e){
                if(!clickable.able)
                    return;
                var item=$(this);
                var id=item.attr("data-id");
                var title=item.attr("data-title");
                if(id){
                    var param=context.application.getObjcDefaultParam();
                    param.target=url.huanguangProductListPage;
                    param.parameters.id=id;
                    param.parameters.type="12";
                    param.parameters.backText=ctrl.titleName;
                    param.parameters.titleText=title;
                    param.level="child";
                    context.application.objcOpen(param);
                }
            });
        }
    }
};
var actions={
    "main":function(context) {
        return "tBody"
    },
    "activitySlider":function(context){
        return "tActivitySlider";
    }
};
var ctrl={
    titleName:"欢逛"
};
OBJC.ready(function(data){
    document.addEventListener("touchmove",function(e){e.preventDefault();return false},false);
    var app=new Application(actions,views).start("main",data);
});

/**测试*/
//$(function(){
//    OBJC.executeJs("init",{backText:"首页",titleText:"欢逛",userId:"402888874cdae817014cdb0cb50f0048"});
//});
