var url=  new function(){
//    this.root="http://www.xinhuan.mobi";
//    this.root="http://117.79.239.194:8080/nhshop";
    this.root="http://123.57.206.88:8080/nhshop";
    this.banner=this.root+"/rest/banner/";
    this.categoryList=this.root+"/rest/category/banner/list/";
    this.productDetailPage=this.root+"/static/goodsDetail.html";
    this.brandCollect=this.root+"/rest/collect/brand";
    this.loginPage="login";
    return this;
};

var views={
    "tBody": {
        template: "tBody",   //模板id
        include: ["tHeader"],
        onComplete: function (ele,context) {   //视图加入文档后所执行的回调函数

            //取活动商品列表数据并显示
            ctrl.currrentId=context.parameter.id;    //通过上一级页面传过来
            ctrl.userId=context.parameter.userId;
            var urlStr=url.banner+ctrl.currrentId+"?offset="+(ctrl.currentPageIndex-1)*ctrl.pageMaxSize+"&max="+(ctrl.pageMaxSize);
            urlStr=ctrl.queryMode==3?urlStr+"&queryMode="+ctrl.queryMode:urlStr;
            urlStr=ctrl.sortMode!=0?urlStr+"&sortMode="+ctrl.sortMode:urlStr;
            context.application.ajaxData(urlStr,"get",{},function(data){
                ctrl.brandId=data.item.brandid;
                context.application.executeAction("productList",data);
                if(ctrl.userId&&ctrl.brandId){
                    setTimeout(function(){
                        var ajaxURl=url.brandCollect+"/"+ctrl.userId+"/has/"+ctrl.brandId;
                        context.application.ajaxData(ajaxURl,"get",{},function(data){
                            if(data.retCode=="14"){
                                ele.find("#btnCollect").addClass("collected");
                            }
                        });
                    },0);
                }
            },undefined,true);
        }
    },
    "tHeader":{
        template:"tHeader",   //模板id
        onComplete:function(ele,context){   //视图加入文档后所执行的回调函数
            //返回按钮
            ele.find("#btnBack").on("tap",function(e){
                context.application.objcClose(context.application.getObjcDefaultParam());
                e.preventDefault();
            });
            //收藏按钮
            ele.find("#btnCollect").on("tap",function(e){
                var self=$(this);
                var pup=$("<div class='pupCollectMsg'><div></div></div>");
                if(ctrl.userId){
                    if(self.hasClass("collected")){
                        var ajaxURl=url.brandCollect+"/"+ctrl.userId+"/del/"+ctrl.brandId;
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
                        var ajaxURl=url.brandCollect+"/"+ctrl.userId+"/add/"+ctrl.brandId;
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
            })
        }
    },
    "tGoodsList":{
        template:"tGoodsList",
        parent:"#goodsList",
//        onBefore:function(ele,context){
//
//        },
        onComplete:function(ele,context){
            ele.find(".goods .adImage").each(function(){
                new AdImage($(this),1);
            });
            ele.find(".goods").on("tap",function(e){
                var item=$(this);
                var id=item.attr("data-id");
                var title=item.attr("data-title");
                if(id){
                    var param=context.application.getObjcDefaultParam();
                    param.target=url.productDetailPage;
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
            window.myScroll&&window.myScroll.refresh(true);
        }
    },
    "tProductList":{
        template:"tProductList",   //模板id
        parent:"#main",
//        onBefore:function(ele,context){
//
//        },
        onComplete:function(ele,context){   //视图加入文档后所执行的回调函数
            ele.find(".goodsWrap").css("min-height",ele.height()+"px");
            //显示列表
            ctrl.goodsFloatFlag=0;
            context.application.executeAction("updateGoodsList",{list:context.data.item.goodsList,elementJoinMethod:"html"});
            //初始化滚动控件
            ctrl.noDataLabel=$("#pullUp");
            var pullDownEl, pullDownOffset;
            pullDownEl = document.getElementById('pullDown');
            pullDownOffset = pullDownEl.offsetHeight;
            var startTime=0;

            window.myScroll=new IScroll("#productList",{
                scrollY:true,scrollX:false,probeType:2
            });

            window.myScroll.on("refresh",function(){
                pullDownEl.className = '';
            });
            window.myScroll.on("scrollStart",function(){
                startTime=0;
            });
            window.myScroll.on("scroll",function(){
                if(!this.y) return;
                startTime=new Date().getTime();
                var lastHeight=this.scrollerHeight-this.wrapperHeight-500;
                if (this.y >0 && this.y <200 && this.y > pullDownOffset && !pullDownEl.className.match('flip')) {
                    pullDownEl.className = 'flip';
                    clearTimeout(pullDownEl.timmer);
                    pullDownEl.timmer=undefined;
                    pullDownEl.timmer=setTimeout(function(){
                        pullDownEl.className+=" fresh";
                        ctrl.fresh=true;
                    },1000);

                }
                if (this.directionY==1 && !ctrl.loadMore && this.y < -(lastHeight)) {
//                    console.log("y:"+this.y +" | my:"+(-(lastHeight))+" | ");
                    ctrl.loadMore=true;
                    ctrl.updateGoodsList(context,ctrl.currentPageIndex+1,"append",false,function(){
                        ctrl.loadMore=false;
                        ctrl.currentPageIndex++;
                    });
                }
            });
            window.myScroll.on("scrollEnd",function(){
                var cur=new Date().getTime();
                var difTime=cur-startTime;
//                console.log("scrollend: s="+cur+" | end="+difTime);
                pullDownEl.className="";
                if(pullDownEl.timmer){
                    clearTimeout(pullDownEl.timmer);
                    pullDownEl.timmer=undefined;
                }
                if (difTime>1000 && ctrl.fresh) {
                    ctrl.currentPageIndex=1;
                    ctrl.updateGoodsList(context,ctrl.currentPageIndex,"html",true,function(){
                        ctrl.fresh=false;
                        ctrl.nodata=false;
                    })
                }
            });
            window.myScroll.refresh();
        }
    }

};
var actions={
    "main":function(context) {
        return "tBody"
    },
    "productList":function(context){
        return "tProductList";
    },
    "updateGoodsList":function(context){
        var list=context.data.list;
        //计算界面中使用哪个css类
        for(var i=0 ; i < list.length ; i++){
            var item=list[i];
            if(item.sizeMark=="big"){
                ctrl.goodsFloatFlag=0;
            }else{
                item.floatCss=ctrl.goodsFloatFlag%2==0? "fLeft":"fRight";
                ctrl.goodsFloatFlag++;
            }
        }
        return "tGoodsList";
    }
};
var ctrl={
    currentPageIndex:1,
    pageMaxSize:6,
    queryMode:0,
    sortMode:0,
    goodsFloatFlag:0,//用于界面中商品靠边方向的确认算法
    updateGoodsList:function(context,page,joinMethod,useLoading,onComplete){
        if((page==1||!ctrl.nodata)){
            //取新品接口数据，然后显示新品界面
            //                    //取新品接口数据，然后显示新品界面
            var urlStr=url.banner+ctrl.currrentId+"?offset="+(page-1)*ctrl.pageMaxSize+"&max="+ctrl.pageMaxSize;
            urlStr=ctrl.queryMode==3?urlStr+"&queryMode="+ctrl.queryMode:urlStr;
            urlStr=ctrl.sortMode!=0?urlStr+"&sortMode="+ctrl.sortMode:urlStr;
            context.application.ajaxData(urlStr,"get",{},function(data){
                if(data.item.goodsList&&data.item.goodsList.length>0){
                    context.application.executeAction("updateGoodsList",{list:data.item.goodsList,elementJoinMethod:joinMethod});
                    ctrl.toggleNodataLabel(false);
                }else{
                    ctrl.toggleNodataLabel(true);
                    ctrl.nodata=true;
                }
                clearTimeout(ctrl.goodsLoading);
                ctrl.goodsLoading=undefined;
            },undefined,useLoading,onComplete);
        }else{
            //Tip("没有更多了");
            ctrl.loadMore=false;
        }
    },
    noDataLabel:undefined,
    toggleNodataLabel:function(show){
        if(show){
            ctrl.noDataLabel.show();
        }else{
            ctrl.noDataLabel.hide();
        }
    },
    getPageIndexData:function(dataArray,index,size){
        index=index<1? 1:index;
        var start=(index-1)*size;
        var end=start+size;
        return dataArray.slice(start,end);
    },
    queryDataFromOriginalData:function(useOriginnal,fun){
        ctrl.currentData=useOriginnal? ctrl.originalData.concat() :ctrl.currentData?  ctrl.currentData :ctrl.originalData.concat();
        if(fun){
            return ctrl.currentData=fun(ctrl.currentData);
        }else{
            return ctrl.currentData;
        }
    },
    calcLastTime:function(dataList){
        for(var i in dataList){
            var remainingSeconds =dataList[i].remainingSeconds;
            remainingSeconds=remainingSeconds? parseInt(remainingSeconds):0;
            var lastTimeText="";
            var minute=60,hour=minute*60,day=hour*24,week=day*7;
            var unit="";
            if(remainingSeconds>=hour){
                if(remainingSeconds>=day){
                        unit="天";
                        lastTimeText=Math.floor(remainingSeconds/day)+unit;
                }else{
                    unit="小时";
                    lastTimeText=Math.floor(remainingSeconds/hour)+unit;
                }
            }else{
                unit="分钟";
                lastTimeText=Math.floor(remainingSeconds/minute)+unit;
            }
            dataList[i].lastTimeText=lastTimeText;
        }
    }
};
OBJC.ready(function(data){
    document.addEventListener("touchmove",function(e){e.preventDefault();return false},false);
    var app=new Application(actions,views).start("main",data);
});

/**测试*/
//$(function(data){
//    OBJC.executeJs("init",{"id":"402888874e541389014e58c3997304e9","type":"12","backText":"欢逛","titleText":"琴溪",userId:"402888874cdae817014cdb0cb50f0048"});
//});
