var url=  new function(){
//    this.root="http://www.xinhuan.mobi";
//    this.root="http://117.79.239.194:8080/nhshop";
    this.root="http://123.57.206.88:8080/nhshop";
    this.special=this.root+"/rest/special/";
    this.categoryList=this.root+"/rest/category/banner/list/";
    this.productDetailPage=this.root+"/static/goodsDetail.html";
    this.bannerProductListPage=this.root+"/static/bannerProductList.html";
    return this;
};

var views={
    "tBody": {
        template: "tBody",   //模板id
        include: ["tHeader"],
        onComplete: function (ele,context) {   //视图加入文档后所执行的回调函数
            //取专场商品列表数据并显示
            ctrl.currrentId=context.parameter.id;    //通过上一级页面传过来
            ctrl.userId=context.parameter.userId;
            var urlStr=url.special+ctrl.currrentId+"?offset="+(ctrl.currentPageIndex-1)*ctrl.pageMaxSize+"&max="+ctrl.pageMaxSize;
            context.application.ajaxData(urlStr,"post",{sortMode:0},function(data){
                data=ctrl.convertData(data,context.parameter.specialPic);
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
                e.preventDefault();return false;
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
                ctrl.currentPageIndex=1;
                ctrl.goodsFloatFlag=0;
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
                ctrl.currentPageIndex=1;
                ctrl.goodsFloatFlag=0;
                ctrl.updateGoodsList(context,ctrl.currentPageIndex,"html",true,function(){
                    ctrl.fresh=false;
                    ctrl.nodata=false;
                })
                ctrl.queryWrap.hide();
                ctrl.queryWrap.showFlag=false;
                e.preventDefault();return false;
            });
            //低价排序
            ele.find("#btnPriceLow").on("tap",function(e){
                ctrl.sortMode=3;
                ctrl.currentPageIndex=1;
                ctrl.goodsFloatFlag=0;
                ctrl.updateGoodsList(context,ctrl.currentPageIndex,"html",true,function(){
                    ctrl.fresh=false;
                    ctrl.nodata=false;
                });
                ctrl.queryWrap.hide();
                ctrl.queryWrap.showFlag=false;
                e.preventDefault();return false;
            });
            //选择品类
            ele.find("#btnCategory").on("tap",function(e){
                if(ctrl.CategoryBody){
                    ctrl.CategoryBody.addClass("in");
                }else{
                    context.application.ajaxData(url.categoryList+ctrl.currrentId,"get",{},function(data){
                        context.application.executeAction("categoryList",data);
                    })
                }
                ctrl.queryWrap.hide();
                ctrl.queryWrap.showFlag=false;
                e.preventDefault();return false;
            });
            //恢复默认
            ele.find("#btnReset").on("tap",function(e){
                ctrl.sortMode=0;
                ctrl.queryMode=0;
                ctrl.ids=undefined;
                ctrl.currentPageIndex=1;
                ctrl.goodsFloatFlag=0;
                ctrl.updateGoodsList(context,ctrl.currentPageIndex,"html",true,function(){
                    ctrl.fresh=false;
                    ctrl.nodata=false;
                });
                ctrl.queryWrap.hide();
                ctrl.queryWrap.showFlag=false;
                btnShowHas.removeClass("checked");
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
            ele.find(".goods .ad .adImage").each(function(){
                new AdImage($(this),0.639);
            });
            ele.find(".banner .ad .adImage").each(function(){
                new AdImage($(this),2.21);
            });
            ele.find(".banner .brandLogo .adImage").each(function(){
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
            ele.find(".banner").on("tap",function(e){
                var item=$(this);
                var id=item.attr("data-id");
                var title=item.attr("data-title");
                if(id){
                    var param=context.application.getObjcDefaultParam();
                    param.target=url.bannerProductListPage;
                    param.parameters.id=id;
                    param.parameters.backText=$("#titleText").text();
                    param.parameters.titleText=title;
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
            context.application.executeAction("updateGoodsList",{list:context.data.goodsList,elementJoinMethod:"html"});
            //初始化滚动控件`
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
        }
    },
    "tCategoryBody":{
        template:"tCategoryBody",
        parent:"body",
        onComplete:function(ele,context){
            document.addEventListener("touchmove",function(e){e.preventDefault();false;},false);
            //初始化滚动
            ele.scrolller=new IScroll("#scrollWrap",{scrollY:true});
            //页面从右滑入并缓存
            var items=ele.find(".item");
            setTimeout(function(){
                ctrl.CategoryBody=ele;
                ctrl.CategoryBody.addClass("in");
            },0);
            items.filter(".all").addClass("selected");
            items.on("tap",function(e){
                var self=$(this);
                var isParent=self.attr("data-parent");
                var id=self.attr("data-id");
                if(isParent=="1"){
                    if(self.hasClass("selected")){
                        self.removeClass("selected");
                    }else{
                        self.addClass("selected");
                        self.nextAll().removeClass("selected");
                    }
                }else{
                    if(self.hasClass("selected")){
                        self.removeClass("selected");
                    }else{
                        self.addClass("selected");
                        self.parent().find(".all").removeClass("selected");
                    }
                }
                e.preventDefault();return false;
            });
            ele.find("#btnCategoryBack").on("tap",function(e){
                ctrl.CategoryBody.removeClass("in");
                e.preventDefault();return false;
            });
            ele.find("#btnDoSelectCategory").on("tap",function(e){
                var selecteds=items.filter(".selected");
                var ids=[];
                selecteds.each(function(){
                    var id=$(this).attr("data-id");
//                    console.log(id);
                    ids.push(id);
                });
                ctrl.CategoryBody.removeClass("in");
                if(ids.length>0){
                    ctrl.ids=ids;
                    ctrl.queryMode=2;
                    ctrl.currentPageIndex=1;
                    ctrl.goodsFloatFlag=0;
                    ctrl.updateGoodsList(context,ctrl.currentPageIndex,"html",true,function(){
                        ctrl.fresh=false;
                        ctrl.nodata=false;
                    })
                }
                e.preventDefault();return false;
            });
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
            var urlStr=url.special+ctrl.currrentId+"?offset="+(page-1)*ctrl.pageMaxSize+"&max="+ctrl.pageMaxSize;
            var param={};
            param.sortMode=ctrl.sortMode;
            if(ctrl.queryMode==2 ||ctrl.queryMode==3){param.queryMode=ctrl.queryMode;}
            if(ctrl.ids) {param.categoryId=ctrl.ids.join('-');}
            context.application.ajaxData(urlStr,"post",param,function(data){
                if(data.item[0].goodsList&&data.item[0].goodsList.length>0){
                    data=ctrl.convertData(data);
                    context.application.executeAction("updateGoodsList",{list:data.goodsList,elementJoinMethod:joinMethod});
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
    convertData:function(data,specialPic){
        var d={specialPic:specialPic,goodsList:[]};
        for(var i=0;i<data.item.length;i++){
            var item=data.item[i];
            if(item.bannertype=="11"){
                var len=item.goodsList.length;
                for(var k=0;k<len;k++){
                    item.goodsList[k].bannertype=item.bannertype;
                    if(ctrl.goodsFloatFlag%2==0){
                        item.goodsList[k].floatCss="fLeft";
                        d.goodsList.push(item.goodsList[k]);
                    }else{
                        item.goodsList[k].floatCss="fRight";
                        d.goodsList.push(item.goodsList[k]);
                        d.goodsList.push({clear:true});
                    }

                    ctrl.goodsFloatFlag++;
                }
            }else{
                if(ctrl.currentPageIndex==1 || (ctrl.currentPageIndex !=1 && !document.getElementById(item.id))){
                    ctrl.calcLastTime(item);
                    d.goodsList.push(item);
                    ctrl.goodsFloatFlag=0;
                }
            }
        }
        return d;
    },
    queryDataFromOriginalData:function(useOriginnal,fun){
        ctrl.currentData=useOriginnal? ctrl.originalData.goodsList.concat() :ctrl.currentData?  ctrl.currentData :ctrl.originalData.goodsList.concat();
        if(fun){
            return ctrl.currentData=fun(ctrl.currentData);
        }else{
            return ctrl.currentData;
        }
    },
    calcLastTime:function(item){
        var remainingSeconds =item.remainingSeconds;
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
        item.lastTimeText=lastTimeText;
    }
};
OBJC.ready(function(data){
    document.addEventListener("touchmove",function(e){e.preventDefault();return false},false);
    var app=new Application(actions,views).start("main",data);
});

/**测试*/
$(function(data){
    OBJC.executeJs("init",{"backText":"新品","titleText":"夏日里的裙装","id":"402888874c2c94af014c2fbbaff20097","specialPic":"http://117.79.239.121/webdav/ec272dfb-f5b1-4c2f-b58f-424efbf9b28e.jpg"});
});
