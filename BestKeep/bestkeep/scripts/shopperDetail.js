var url=  new function(){
//    this.root="http://www.xinhuan.mobi";
//    this.root="http://117.79.239.194:8080/nhshop";
    this.root="http://123.57.206.88:8080/nhshop";
    this.shareLink="http://shop.xinhuan.mobi/index.php?r=goods/detail&id=";
    this.goodsCollect=this.root+"/rest/collect";
    this.goodsdetail=this.root+"/rest/goods";
    this.loginPage="login";
    return this;
};

var views={
    "tBody": {
        template: "tBody",   //模板id
        onComplete: function (ele,context) {   //视图加入文档后所执行的回调函数
            ele.find("#btnBack").on("tap",function(e){
                context.application.objcClose(context.application.getObjcDefaultParam());
                e.preventDefault();
            });
            ctrl.currrentId=context.parameter.id;
            ctrl.userId=context.parameter.userId;
            //取商品详情接口数据
            var detailURL=url.goodsdetail+"/"+ctrl.currrentId;
            if(ctrl.userId) {detailURL+="?userId="+ctrl.userId;}
            context.application.ajaxData(detailURL,"get",{},function(data){
                context.application.executeAction("goodsDetail",data);
//                if(ctrl.currrentId && ctrl.userId){
//                    var ajaxURl=url.goodsCollect+"/"+ctrl.userId+"/has/"+ctrl.currrentId;
//                    context.application.ajaxData(ajaxURl,"get",{},function(data){
//                        if(data.retCode=="14"){
//                            ele.find("#btnCollect").addClass("collected");
//                        }
//                    });
//                }
            },undefined,true);
        }
    },
    "tGoodsDetail":{
        template:"tGoodsDetail",   //模板id
        parent:"#main",
        onBefore:function(ele,context){
            var documentWidth=$("body").width();
            ele.find("#adWrap").css("minHeight",documentWidth+"px");
        },
        onComplete:function(ele,context){   //视图加入文档后所执行的回调函数
            ele.find(".adImage").each(function(){
                new AdImage($(this),'auto',null);
            });
            window.myScroll=GoodsScroller("#goodsScrollWrap",context);
            //点击立即购买
            ele.find(".btnBuy").on("tap",function(e){
                if(ctrl.userId){
                    var self=$(this);
                    var third_party_url=self.attr("data-url");
                    var title=self.attr("data-title");
                    if(third_party_url){
                        var param=context.application.getObjcDefaultParam();
                        param.target=third_party_url;
                        param.parameters.backText="导购详情";
                        param.parameters.titleText=title;
                        param.parameters.goodsId=ctrl.currrentId;
                        param.component.push("NavigationBar");
                        param.layout="0";
                        param.level="child";
                        context.application.objcOpen(param);
                    }
                }else{
                    var param=context.application.getObjcDefaultParam();
                    param.target=url.loginPage;
                    param.parameters.backText=$("#titleText").text();
                    param.parameters.titleText="登陆";
                    param.level="child";
                    context.application.objcOpen(param,function(data){
                        if(data.userId){
                            ctrl.userId=data.userId;
                        }
                    });
                }

                e.preventDefault();return false;
            });
//            //点击收藏
//            ele.find("#btnCollect").on("tap",function(e){
//                var self=$(this);
//                var pup=$("<div class='pupCollectMsg'><div></div></div>");
//                if(ctrl.userId){
//                    if(self.hasClass("collected")){
//                        var ajaxURl=url.goodsCollect+"/"+ctrl.userId+"/del/"+ctrl.currrentId;
//                        context.application.ajaxData(ajaxURl,"get",{},function(data){
//                            if(data.retCode=="0"){
//                                pup.addClass("uncollect").addClass("success");
//                                self.removeClass("collected");
//                            }else{
//                                pup.addClass("uncollect").addClass("feild");
//                            }
//                            $("#main").append(pup);
//                            pup.fadeIn(300);
//                            setTimeout(function(){
//                                pup.fadeOut(300);
//                                setTimeout(function(){
//                                    pup.remove();
//                                },300)
//                            },1500);
//                        });
//                    }else{
//                        var ajaxURl=url.goodsCollect+"/"+ctrl.userId+"/add/"+ctrl.currrentId;
//                        context.application.ajaxData(ajaxURl,"get",{},function(data){
//                            if(data.retCode=="0"){
//                                pup.addClass("collect").addClass("success");
//                                self.addClass("collected");
//                            }else{
//                                pup.addClass("collect").addClass("feild");
//                            }
//                            $("#main").append(pup);
//                            pup.fadeIn(300);
//                            setTimeout(function(){
//                                pup.fadeOut(300);
//                                setTimeout(function(){
//                                    pup.remove();
//                                },300)
//                            },1500);
//                        });
//                    }
//                }else{
//                    var param=context.application.getObjcDefaultParam();
//                    param.target=url.loginPage;
//                    param.parameters.backText=$("#titleText").text();
//                    param.parameters.titleText="登陆";
//                    param.level="child";
//                    context.application.objcOpen(param,function(data){
//                        if(data.userId){
//                            ctrl.userId=data.userId;
//                        }
//                    });
//                }
//                e.preventDefault();return false;
//            });
            //点击分享
//            ele.find("#btnShare").on("tap",function(e){
//                var param=context.application.getObjcDefaultParam();
//                param.target="share";
//                param.level="component";
//                param.parameters.url=url.shareLink+ctrl.currrentId;
//                param.parameters.title=context.data.item.goodsname;
//                param.parameters.description=context.data.item.goodsdetail;
//                param.parameters.iconUrl=context.data.item.shareIcon || "http://www.xinhuan.mobi/image/logo.png";
//                context.application.objcOpen(param);
//                e.preventDefault();return false;
//            });
        }
    }
};
var actions={
    "main":function(context) {
        return "tBody";
    },
    "goodsDetail":function(context){
        return "tGoodsDetail";
    }
};
var ctrl={

};
OBJC.ready(function(data){
    document.addEventListener("touchmove",function(e){e.preventDefault();return false},false);
    var app=new Application(actions,views).start("main",data);
});
function GoodsScroller(eleId,context){
    var s=new IScroll(eleId,{scrollY:true,probeType:3});
    var btnBuy01=$("#btnBuy01");
    var btnBuy02=$("#flotPriceWrap");
    var btnBuy01Top=btnBuy01.position().top;
    var btnBuy01Flag=false,btnBuy02Flag=true;
//    console.log(btnBuy01Top);
    s.on("scroll",function(){
//                console.log(this.distY);
        if(!btnBuy01Flag&& this.y<=-btnBuy01Top){
//            console.log("in:" +this.y);
            btnBuy01Flag=true;
            btnBuy02.addClass("in");
            btnBuy02Flag=false;
        }else if(!btnBuy02Flag && this.y>-btnBuy01Top){
//            console.log("out:" +this.y);
            btnBuy02.removeClass("in");
            btnBuy02Flag=true;
            btnBuy01Flag=false;
        }
//                console.log( h+" | "+this.maxScrollY+" | "+Math.abs(this.maxScrollY-this.y));
    });
    return s;
}

/**测试*/
//$(function(data){
////    OBJC.executeJs('init',{'id':'54f86727a334417ebc5ee4ba8adcc0da','userId':'402888874cb870d1014cbaca3960002d','titleText':'测试数据，请勿购买','backText':''})
//OBJC.executeJs('init',{'id':'b5357da3b3fb4d8fbf8495ec2ce11cdd','userId':'402888874cb870d1014cbaca3960002d','titleText':'SEXYLOOK深层透亮','backText':''});
//});
