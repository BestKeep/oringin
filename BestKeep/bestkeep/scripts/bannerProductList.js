var url=  new function(){
    this.root="http://123.57.206.88:8080/bestkeep";
//    this.banner=this.root+"/rest/banner/";
//    this.categoryList=this.root+"/rest/category/banner/list/";
    this.productDetailPage=this.root+"/list.html";
//    this.brandCollect=this.root+"/rest/collect/brand";
//    this.loginPage="login";
    return this;
};

var views={
    "tBody": {
        template: "tBody",   //模板id
        include: ["tNav"],
        onComplete: function (ele,context) {   //视图加入文档后所执行的回调函数

            //取活动商品列表数据并显示
            ctrl.currrentId=context.parameter.id;    //通过上一级页面传过来
            ctrl.userId=context.parameter.userId;
            context.application.executeAction("productList",{});
        }
    },
    "tNav":{
      template:"tNav",//导航tNav模板
      onComplete:function(ele,context){
          var navBtn = ele.find("#navBtn li");
          
            navBtn.on("tap",function(e){
               $(this).siblings().removeClass('active');
                $(this).addClass('active');
                var url ="http://www.latheknox.com/top/"+$(this).attr('id');
               $.ajax({ //ajax加载数据及绑定事件步骤
                   type:"GET",
                   url:'http://www.latheknox.com/top/'+$(this).attr('id'),
                   dataType:"jsonp",
                   jsonpCallback:"jsonp",
                   timeout:20000, 
                   beforeSend:function(){
                       $('#goodsList').empty()
                       var load = $('<p class="loading"></p>')
                       load.insertAfter('.header');
                   },
                   success:function(jsonp){
                       var html = ""
                       for(var i=0;i<jsonp.feaTitle.length;i++){
                           html += '<li class="goodsItem inited" id="测试id" data-title="测试title">';
                           html +='<div class="goods" data-id="测试id:12331" data-title="测试title:12331">';
                           html +='<div class="ad">';
                           html += '<div class="adImage loaded" data-ref="'+jsonp.image[i]+'"><img src="'+jsonp.image[i]+'"></div></div>';
                           html +='<div class="text">'
                           html +='<h2 class="feaTitle">'+jsonp.feaTitle[i] +'</h2>';
                           html +='<p class="summary">'+jsonp.summary[i]+'</p></div></div>';
                           html +='</li>';
                       }
                       $('#goodsList').html(html);
                       
                   },
                   complete:function(){
                       $('.loading').remove()
                       $(".goods").on("tap",function(e){
                            var item=$(this);
                            var id=item.attr("data-id");
                            var title=item.attr("data-title");
                            if(id){
                                var param=context.application.getObjcDefaultParam();
                                param.target=url;//.productDetailPage;
                                param.parameters.id=id;
                                param.parameters.backText=$("#titleText").text();
                                param.parameters.titleText=title;
                                param.component.push("");
                                param.layout="1";
                                param.level="child";
                                context.application.objcOpen(param);
                                }
                            e.preventDefault();
                            return false;
                        });
                   }
               })
                e.preventDefault()
            })
      }
    },    
    "tGoodsList":{
        template:"tGoodsList",
        parent:"#goodsList",
        onBefore:function(ele,context){
            ele.find(".goods .adImage").each(function(){
                new AdImage($(this),0.639);
            });
        },
        onComplete:function(ele,context){
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
                    param.component.push("");
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
        onBefore:function(ele,context){
//
        },
        onComplete:function(ele,context){   //视图加入文档后所执行的回调函数
            //顶部banner图片加载
            ele.find(".goodsWrap").css("min-height",ele.height()+"px");
            ele.find(".bannerImage .adImage").each(function(){
                new AdImage($(this),2.216);
            });
            //筛选框
            ctrl.queryWrap=$("#queryWrap");
            ctrl.queryWrap.on("tap touchmove",function(e){
                ctrl.queryWrap.hide();
                ctrl.queryWrap.showFlag=false;
                e.preventDefault();return false;
            });
            //显示列表
            ctrl.goodsFloatFlag=0;
            context.application.executeAction("updateGoodsList",{list:{},elementJoinMethod:"html"});
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
        
        context.data.list={};
        return "tGoodsList";
    }
};
var ctrl={
    currentPageIndex:1,
    pageMaxSize:6,
    queryMode:0,
    sortMode:0,
    goodsFloatFlag:0,
    updateGoodsList:function(context,page,joinMethod,useLoading,onComplete){
        if((page==1||!ctrl.nodata)){
            context.application.executeAction("updateGoodsList",{list:{},elementJoinMethod:joinMethod});
            ctrl.toggleNodataLabel(false);
            //取接口数据，然后显示界面
        }else{
           // Tip("没有更多了");
            ctrl.loadMore=false;
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
    noDataLabel:undefined,
    toggleNodataLabel:function(show){
        if(show){
            ctrl.noDataLabel.show();
        }else{
            ctrl.noDataLabel.hide();
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
$(function(data){
    OBJC.executeJs("init",{backText:"新品",titleText:"乐町",id:"402888874b2b001e014b2e4dd49c00e5",userId:"402888874cdae817014cdb0cb50f0048"});
});
