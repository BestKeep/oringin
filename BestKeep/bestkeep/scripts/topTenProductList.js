var url=  new function(){
//    this.root="http://www.xinhuan.mobi";
//    this.root="http://117.79.239.194:8080/nhshop";
    this.root="http://123.57.206.88:8080/nhshop";
    this.banner=this.root+"/rest/banner/";
    this.productDetailPage=this.root+"/static/goodsDetail.html";
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
            var urlStr=url.banner+ctrl.currrentId+"?offset="+(ctrl.currentPageIndex-1)*ctrl.pageMaxSize+"&max="+ctrl.pageMaxSize;
            urlStr=ctrl.queryMode==3?urlStr+"&queryMode="+ctrl.queryMode:urlStr;
            urlStr=ctrl.sortMode!=0?urlStr+"&sortMode="+ctrl.sortMode:urlStr;
            context.application.ajaxData(urlStr,"get",{},function(data){

                context.application.executeAction("productList",data);

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
            //筛选按钮
            ele.find("#btnQuery").on("tap",function(e){
                if(ctrl.queryWrap){
                    if(!ctrl.queryWrap.showFlag){
                        ctrl.queryWrap.show();
                        ctrl.queryWrap.showFlag=true;
                    }else{
                        ctrl.queryWrap.hide();
                        ctrl.queryWrap.showFlag=false;
                    }
                }
                e.preventDefault();return false;
            });

        }
    },
    "tQuery":{
        template:"tQuery",   //模板id
        onComplete:function(ele,context){   //视图加入文档后所执行的回调函数
            //显示有货
            var btnShowHas=ele.find("#btnShowHas");
            btnShowHas.on("tap",function(e){
                if(ctrl.queryMode==3){
                    ctrl.queryMode=0;
                    btnShowHas.removeClass("checked");
                }else{
                    ctrl.queryMode=3;
                    btnShowHas.addClass("checked");
                }
                ctrl.goodsFloatFlag=0;
                ctrl.currentPageIndex=1;
                ctrl.updateGoodsList(context,ctrl.currentPageIndex,"html",true,function(){
                    ctrl.fresh=false;
                    ctrl.nodata=false;
                });
                ctrl.queryWrap.hide();
                ctrl.queryWrap.showFlag=false;
                e.preventDefault();return false;
            });
            //高价排序
            ele.find("#btnPriceHigh").on("tap",function(e){
                ctrl.sortMode=4;
                ctrl.goodsFloatFlag=0;
                ctrl.currentPageIndex=1;
                ctrl.updateGoodsList(context,ctrl.currentPageIndex,"html",true,function(){
                    ctrl.fresh=false;
                    ctrl.nodata=false;
                });
                ctrl.queryWrap.hide();
                ctrl.queryWrap.showFlag=false;
                e.preventDefault();return false;
            });
            //低价排序
            ele.find("#btnPriceLow").on("tap",function(e){
                ctrl.sortMode=3;
                ctrl.goodsFloatFlag=0;
                ctrl.currentPageIndex=1;
                ctrl.updateGoodsList(context,ctrl.currentPageIndex,"html",true,function(){
                    ctrl.fresh=false;
                    ctrl.nodata=false;
                });
                ctrl.queryWrap.hide();
                ctrl.queryWrap.showFlag=false;
                e.preventDefault();return false;
            });
            //恢复默认
            ele.find("#btnReset").on("tap",function(e){
                ctrl.sortMode=0;
                ctrl.queryMode=0;
                ctrl.goodsFloatFlag=0;
                ctrl.currentPageIndex=1;
                ctrl.updateGoodsList(context,ctrl.currentPageIndex,"html",true,function(){
                    ctrl.fresh=false;
                    ctrl.nodata=false;
                    btnShowHas.removeClass("checked");
                });
                ctrl.queryWrap.hide();
                ctrl.queryWrap.showFlag=false;

                e.preventDefault();return false;
            });
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
                new AdImage($(this),0.639);
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
        include:["tQuery"],
//        onBefore:function(ele,context){
//
//        },
        onComplete:function(ele,context){   //视图加入文档后所执行的回调函数
            //顶部banner图片加载
            ele.find(".bannerImage .adImage").each(function(){
                new AdImage($(this),3.76);
            });
            ele.find(".goodsWrap").css("min-height",ele.height()+"px");
            //筛选框
            ctrl.queryWrap=$("#queryWrap");
            ctrl.queryWrap.on("tap touchmove",function(e){
                ctrl.queryWrap.hide();
                ctrl.queryWrap.showFlag=false;
                e.preventDefault();return false;
            });
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
                    ctrl.goodsFloatFlag=0;
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
    "categoryList":function(context){
        return "tCategoryBody";
    },
    "updateGoodsList":function(context){
        var list=context.data.list;
        var _list=[];
        //计算界面中使用哪个css类
        for(var i=0 ; i < list.length ; i++){
            var item=list[i];
            if(ctrl.goodsFloatFlag%2==0){
                item.floatCss="fLeft";
               _list.push(item);
            }else{
                item.floatCss="fRight";
                _list.push(item);
                _list.push({clear:true});
            }
            ctrl.goodsFloatFlag++;
        }
        context.data.list=_list;
        return "tGoodsList";
    }
};
var ctrl={
    currentPageIndex:1,
    pageMaxSize:12,
    queryMode:0,
    sortMode:0,
    goodsFloatFlag:0,
    updateGoodsList:function(context,page,joinMethod,useLoading,onComplete){
        if((page==1||!ctrl.nodata)){
            //取接口数据，然后显示新品界面
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
//    OBJC.executeJs("init",{backText:"新品",titleText:"top10",id:"402888d84df5edd1014df6711a9d00cf",userId:"402888874cdae817014cdb0cb50f0048"});
//});
