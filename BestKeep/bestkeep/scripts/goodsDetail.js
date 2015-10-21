var url=  new function(){
//    this.root="http://www.xinhuan.mobi";
//    this.root="http://117.79.239.194:8080/nhshop";
    this.root="http://123.57.206.88:8080/nhshop";
    this.shareLink="http://shop.xinhuan.mobi/index.php?r=goods/detail&id=";
    this.goodsdetail=this.root+"/rest/goods";
    this.otherbuy=this.root+"/rest/shopping/people/like";
    this.goodsCollect=this.root+"/rest/collect";
    this.goodsdetailPage=this.root+"/static/goodsDetail.html";
    this.goodsMoreDetailPage=this.root+"/static/goodsMoreDetail.html";
    this.goodsSizeTablePage=this.root+"/static/goodsSizeTable.html";
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
                if(ctrl.currrentId && ctrl.userId){
                    var ajaxURl=url.goodsCollect+"/"+ctrl.userId+"/has/"+ctrl.currrentId;
                    context.application.ajaxData(ajaxURl,"get",{},function(data){
                        if(data.retCode=="14"){
                            ele.find("#btnCollect").addClass("collected");
                        }
                    });
                }
            },undefined,true);
        }
    },
    "tGoodsDetail":{
        template:"tGoodsDetail",   //模板id
        parent:"#main",
        onComplete:function(ele,context){   //视图加入文档后所执行的回调函数
            var documentHeight=$("body").height();
            var documentWidth=$("body").width();
            var adWrap=ele.find("#adWrap");
            adWrap.height(documentHeight+"px");
            var mySwipe=new Swipe(document.getElementById("adSwipe"),{
                startSlide: 0,
                auto:0,
                continuous: true,
                disableScroll: false,
                stopPropagation: false,
                callback: undefined,
                transitionEnd: undefined
            });
            if(context.data.item.videoUrlPath){
                ctrl.video=new XHVideo(document.getElementById("adVideo"),{
                    face:ele.find("#face"),
                    btnPlay:ele.find("#btnPlay"),
                    loading:ele.find("#loading"),
                    swipe:undefined,
                    width:documentWidth,
                    height:documentHeight
                });
            }
            adWrap.find(".adImage").each(function(){
                new AdImage($(this),"full");
            });

            //开启倒计时
            if(context.data.item.remainingSeconds){
                new XHTimer(ele.find("#lastTime"),context.data.item.remainingSeconds);
            }
            var sizeList=ele.find("#sizeWrap .size .item");
            var colorList=ele.find("#sizeWrap .color .item");
            var selectedColor=undefined;
            var selectedSize=undefined;
            var selectedGoodsExt=undefined;
            var enableSizeLen=0;
            var enableColorLen=0;
            //点击尺码
            sizeList.on("tap",function(e){
                var self=$(this);
                if(!self.hasClass("disable") && !self.hasClass("selected")){
                    var size=self.attr("data-value");
                    enableSizeLen=0;
                    var data=context.data.item.goodsExt;
                    var disableColors={};
                    var enableColors={};
                    for(var i=0;i<data.length;i++){
                        var item=data[i];
                        if(item.sizeId==size && item.inventoryAmount>0){
                            enableColors[item.colorId]="1";
                            enableColorLen++;            //不是真实可用颜色数，此属性只记录出现次数
                        }else {
                            disableColors[item.colorId]="1";
                        }
                    }
                    colorList.removeClass("selected");
                    for (var key1 in enableColors){
                        colorList.filter("[data-value='"+key1+"']").removeClass("disable");
                    }
                    for (var key2 in disableColors){
                        if(enableColors[key2]!="1"){
                            colorList.filter("[data-value='"+key2+"']").addClass("disable");
                        }
                    }

                    if(selectedColor){
                        colorList.filter("[data-value='"+selectedColor+"']").addClass("selected");
                    }else{
                        for (var key3 in enableColors){
                            colorList.filter("[data-value='"+key3+"']").addClass("selected");
                            selectedColor=key3;
                            break;
                        }
                    }
                    sizeList.removeClass("selected");
                    self.addClass("selected");
                    selectedSize=size;
                    selectedGoodsExt= data.filter(function(item,i){
                        return item.colorId==selectedColor && item.sizeId==size;
                    });
                    if(selectedGoodsExt && selectedGoodsExt.length>0){
                        selectedGoodsExt=selectedGoodsExt[0];
                    }
                    if(selectedGoodsExt.id){
                        selectedGoodsExt.imgUrl=context.data.item.bigPicture;
                        selectedGoodsExt.salePrice=context.data.item.saleprice;
                        selectedGoodsExt.labelPrice=context.data.item.labelprice;
                        selectedGoodsExt.goodsName=context.data.item.shortName;
                        context.application.objcSetCatchData("goodsExt",selectedGoodsExt);
                    }else{
                        selectedGoodsExt={};
                        selectedGoodsExt.imgUrl=context.data.item.bigPicture;
                        selectedGoodsExt.salePrice=context.data.item.saleprice;
                        selectedGoodsExt.labelPrice=context.data.item.labelprice;
                        selectedGoodsExt.goodsName=context.data.item.shortName;
                        context.application.objcSetCatchData("goodsExt",selectedGoodsExt);
                    }

                }
                e.preventDefault();return false;
            });
            //点击颜色
            colorList.on("tap",function(e){
                var self=$(this);
                if(!self.hasClass("disable") && !self.hasClass("selected")){
                    var color=self.attr("data-value");
                    var data=context.data.item.goodsExt;
                    var disableSize={};
                    var enableSize={};
                    enableColorLen=0;
                    for(var i=0;i<data.length;i++){
                        var item=data[i];
                        if(item.colorId==color && item.inventoryAmount>0){
                            enableSize[item.sizeId]="1";
                            enableSizeLen++;       //不是真实可用尺码数，此属性只记录出现次数
                        }else {
                            disableSize[item.sizeId]="1";
                        }
                    }
                    sizeList.removeClass("selected");
                    for (var key1 in enableSize){
                        sizeList.filter("[data-value='"+key1+"']").removeClass("disable");
                    }
                    for (var key2 in disableSize){
                        if(enableSize[key2]!="1"){
                            sizeList.filter("[data-value='"+key2+"']").addClass("disable");
                        }
                    }

                    if(selectedSize){
                        sizeList.filter("[data-value='"+selectedSize+"']").addClass("selected");
                    }else{
                        for (var key3 in enableSize){
                            sizeList.filter("[data-value='"+key3+"']").addClass("selected");
                            selectedSize=key3;
                            break;
                        }
                    }
                    colorList.removeClass("selected");
                    self.addClass("selected");
                    selectedColor=color;
                    selectedGoodsExt= data.filter(function(item,i){
                        return item.colorId==color && item.sizeId==selectedSize;
                    });
                    if(selectedGoodsExt && selectedGoodsExt.length>0){
                        selectedGoodsExt=selectedGoodsExt[0];
                    }
                    if(selectedGoodsExt.id){
                        selectedGoodsExt.imgUrl=context.data.item.bigPicture;
                        selectedGoodsExt.salePrice=context.data.item.saleprice;
                        selectedGoodsExt.labelPrice=context.data.item.labelprice;
                        selectedGoodsExt.goodsName=context.data.item.shortName;
                        context.application.objcSetCatchData("goodsExt",selectedGoodsExt);
                    }else{
                        selectedGoodsExt={};
                        selectedGoodsExt.imgUrl=context.data.item.bigPicture;
                        selectedGoodsExt.salePrice=context.data.item.saleprice;
                        selectedGoodsExt.labelPrice=context.data.item.labelprice;
                        selectedGoodsExt.goodsName=context.data.item.shortName;
                        context.application.objcSetCatchData("goodsExt",selectedGoodsExt);
                    }
                }
                e.preventDefault();return false;

            });
            //点击第一个可用的尺码
            var extList=context.data.item.goodsExt;
            var sizeIdList=context.data.sizeList;
            for(var k in sizeIdList){
                var id=sizeIdList[k];
                var flag=false;
                for (var x in extList ){
                    var ext=extList[x];
                    if(ext.sizeId==id &&ext.inventoryAmount>0){
                        flag=true;
                        break;
                    }
                }
                if(flag) {
                    sizeList.filter("[data-value='"+id+"']").tap();
                    break;
                }else{
                    sizeList.filter("[data-value='"+id+"']").addClass("disable");
                }
            }
            //单一尺码默认选中状态，多个尺码默认不选中状态
            if(enableSizeLen>1){
                //sizeList.removeClass("selected");
            }
            //单一颜色默认选中状态，多个颜色默认不选中状态
            if(enableColorLen>1){
                //colorList.removeClass("selected");
            }
            //点击更多详情
            ele.find("#btnMoreInfo").on("tap",function(e){
                var param=context.application.getObjcDefaultParam();
                param.target=url.goodsMoreDetailPage;
                param.level="child";
                param.parameters={backText:"返回",titleText:"更多详情",picList:context.data.item.contentPic};
                context.application.objcOpen(param);
            });
            //点击尺码表
            ele.find("#btnSizeTable").on("tap",function(e){
                var param=context.application.getObjcDefaultParam();
                param.target=url.goodsSizeTablePage;
                param.level="child";
                param.parameters={backText:"返回",titleText:"尺码表",sizeTable:context.data.item.sizeTable,sizePicPath:context.data.item.sizePicPath,sizeinfodetail:context.data.item.sizeinfodetail,unit:context.data.item.units};
                context.application.objcOpen(param);
                e.preventDefault();return false;
            });

            window.myScroll=GoodsScroller("#goodsScrollWrap",context);
            //点击收藏
            ele.find("#btnCollect").on("tap",function(e){
                var self=$(this);
                var pup=$("<div class='pupCollectMsg'><div></div></div>");
                if(ctrl.userId){
                    if(self.hasClass("collected")){
                        var ajaxURl=url.goodsCollect+"/"+ctrl.userId+"/del/"+ctrl.currrentId;
                        context.application.ajaxData(ajaxURl,"get",{},function(data){
                            if(data.retCode=="0"){
                                pup.addClass("uncollect").addClass("success");
                                self.removeClass("collected");
                            }else{
                                pup.addClass("uncollect").addClass("feild");
                            }
                            $("#main").append(pup);
                            pup.fadeIn(300);
                            setTimeout(function(){
                                pup.fadeOut(300);
                                setTimeout(function(){
                                    pup.remove();
                                },300)
                            },1500);
                        });
                    }else{
                        var ajaxURl=url.goodsCollect+"/"+ctrl.userId+"/add/"+ctrl.currrentId;
                        context.application.ajaxData(ajaxURl,"get",{},function(data){
                            if(data.retCode=="0"){
                                pup.addClass("collect").addClass("success");
                                self.addClass("collected");
                            }else{
                                pup.addClass("collect").addClass("feild");
                            }
                            $("#main").append(pup);
                            pup.fadeIn(300);
                            setTimeout(function(){
                                pup.fadeOut(300);
                                setTimeout(function(){
                                    pup.remove();
                                },300)
                            },1500);
                        });
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
            //点击分享
            ele.find("#btnShare").on("tap",function(e){
                var param=context.application.getObjcDefaultParam();
                param.target="share";
                param.level="component";
                param.parameters.url=url.shareLink+ctrl.currrentId;
                param.parameters.title=context.data.item.goodsname;
                param.parameters.description=context.data.item.goodsdetail;
                param.parameters.iconUrl=context.data.item.shareIcon || "http://www.xinhuan.mobi/image/logo.png";
                context.application.objcOpen(param);
                e.preventDefault();return false;
            });
            //取其他人购买接口数据
            context.application.ajaxData(url.otherbuy,"get",{},function(data){
                context.application.executeAction("otherBuy",data);
            });
        }
    },
    "tOtherBuy":{
        template:"tOtherBuy",
        parent:"#otherBuyWrap",
        onComplete:function(ele,context){
            ele.find(".adImage").each(function(){
                new AdImage($(this),0.64);
            });
            ele.find(".item").on("tap",function(e){
                var item=$(this);
                var id=item.attr("data-id");
                var title=item.attr("data-title");
                if(id){
                    var param=context.application.getObjcDefaultParam();
                    param.target=url.goodsdetailPage;
                    param.parameters.id=id;
                    param.parameters.backText=$("#titleText").text();
                    param.parameters.titleText=title;
                    param.component.push("shopbar");
                    param.layout="1";
                    param.level="child";
                    context.application.objcOpen(param);
                }
                e.preventDefault();return false;
            });

        }
    }
};
var actions={
    "main":function(context) {
        return "tBody";
    },
    "goodsDetail":function(context){
        //处理尺码数据
        var data=context.data;
        data.sizeList=[];
        data.colorList=[];
        var sizeMap={},colorMap={};
        for(var i=0;i<data.item.goodsExt.length;i++){
            var v=data.item.goodsExt[i];
            sizeMap[v.sizeId]="1";
            colorMap[v.colorId]="1";
        }
        for(var s in sizeMap){
            data.sizeList.push(s);
        }
        for(var c in colorMap){
            data.colorList.push(c);
        }
        return "tGoodsDetail";
    },
    "otherBuy":function(context){
        return "tOtherBuy";
    }
};
var ctrl={

};
OBJC.ready(function(data){
    document.addEventListener("touchmove",function(e){e.preventDefault();return false},false);
    var app=new Application(actions,views).start("main",data);
});


function XHVideo(videoElement,option){
    if(videoElement){
        videoElement.width=option.width;
        option.btnPlay.fadeIn(200);
        $(videoElement).hide();
        videoElement.addEventListener("play",function(){
            option.loading &&option.loading.show();
            option.swipe && option.swipe.stop();
            option.btnPlay.fadeOut(200);
            videoElement.width=option.width;
            $(videoElement).show();
        },false);
        videoElement.addEventListener("playing",function(){
            option.face&&option.face.hide();
            option.swipe && option.swipe.stop();
            option.loading &&option.loading.hide();
//            console.log("playing");
        },false);
        videoElement.addEventListener("ended",function(){
//            console.log("ended");
            $(videoElement).hide();
            option.face&&option.face.show();
            option.btnPlay.fadeIn(200);
            option.swipe && option.swipe.begin();
        },false);
        if(option.btnPlay){
            option.btnPlay.on("tap",function(e){
                videoElement.play();
            });
        }
        videoElement.src=videoElement.getAttribute("data-src");
    }
    return videoElement
}
function GoodsScroller(eleId,context){
    var s=new IScroll(eleId,{scrollY:true,probeType:2});
    var otherBuyWrap=$("#otherBuyWrap");
    var hideExe=true;
    var showExe=true;
    s.on("scroll",function(){
//                console.log(this.distY);
        var h=otherBuyWrap.height();
        h=h-h*0.2;
        if(hideExe&& this.distY<0 && Math.abs(this.maxScrollY-this.y) <= h){
            hideExe=false;
            showExe=true;
            var param=context.application.getObjcDefaultParam();
            param.target="shopbar";
            param.level="component";
            context.application.objcClose(param);
        }else if(showExe&& this.distY>=0 && Math.abs(this.maxScrollY-this.y) > h){
            showExe=false;
            hideExe=true;
            var param=context.application.getObjcDefaultParam();
            param.target="shopbar";
            param.level="component";
            context.application.objcOpen(param);
        }
//                console.log( h+" | "+this.maxScrollY+" | "+Math.abs(this.maxScrollY-this.y));
    });
    return s;
}
/**测试*/
$(function(data){
    OBJC.executeJs('init',{'id':'2bcf6ffa4a420313014a4c4c001001fa','userId':'402888874cdae817014cdb0cb50f0048','titleText':'测试数据，请勿购买','backText':''});
});
