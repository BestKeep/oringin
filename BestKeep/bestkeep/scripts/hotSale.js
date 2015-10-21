var url=  new function(){
//    this.root="http://www.xinhuan.mobi";
    this.root="http://117.79.239.194:8080/nhshop";
//    this.root="http://123.57.206.88:8080/nhshop";
    this.xinpin=this.root+"/rest/banner/na_1/list";
    this.carousel=this.root+"/rest/carousel";
    this.specialProductListPage=this.root+"/static/specialProductList.html";
    this.bannerProductListPage=this.root+"/static/bannerProductList.html";
    this.productDetailPage=this.root+"/static/goodsDetail.html";
    this.topTenProductListPage=this.root+"/static/topTenProductList.html";
    this.shopperProductListPage=this.root+"/static/shopperProductList.html";
    this.couponsPage="http://shop.xinhuan.mobi/index.php?r=coupon/prod";
    return this;
};

var views={
    "tBody": {
        template: "tBody",   //模板id
        include: ["tHeader"],
        onComplete: function (ele,context) {   //视图加入文档后所执行的回调函数
            ctrl.userId=context.parameter.userId;
            //取轮播图接口数据，然后显示轮播界面
            context.application.ajaxData(url.carousel,"get",{},function(data){
                if(data.list.length>1){
                    data.useNav=true;
                }else{
                    data.useNav=false;
                }
                context.application.executeAction("carousel",data);
            },undefined,true);
            //取新品接口数据，然后显示商品界面
            var urlStr=url.xinpin+"?offset="+(ctrl.currentPageIndex-1)*ctrl.pageMaxSize+"&max="+ctrl.pageMaxSize;
            context.application.ajaxData(urlStr,"get",{},function(data){
                ctrl.calcLastTime(data.list);
                context.application.executeAction("product",{data:data,elementJoinMethod:"html"});
            },undefined,true);
            //初始化滚动控件
            ctrl.noDataLabel=$("#pullUp");
            var pullDownEl, pullDownOffset;
//                pullUpEl, pullUpOffset,
//                generatedCount = 0;
            pullDownEl = document.getElementById('pullDown');
            pullDownOffset = pullDownEl.offsetHeight;
//            pullUpEl = document.getElementById('pullUp');
//            pullUpOffset = pullUpEl.offsetHeight;
            var startTime=0;

            window.myScroll=new IScroll("#main",{
                scrollY:true,scrollX:false,probeType:2,scrollbars:true
            });

            window.myScroll.on("refresh",function(){
                pullDownEl.className = '';
            });
            window.myScroll.on("scrollStart",function(){
                startTime=0;
//                console.log("start:"+startTime);
            });
            var timeout;
            window.myScroll.on("scroll",function(){
                //console.log(this.y);
                clearTimeout(timeout);
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
                if(window.mySwipe && !window.mySwipe.autoLoop && this.y>-200){
                    window.mySwipe.begin();
                    window.mySwipe.autoLoop=true;
                }else if(window.mySwipe && window.mySwipe.autoLoop && this.y<=-200){
                    window.mySwipe.stop();
                    window.mySwipe.autoLoop=false;
                }

            });

            var lazyImg = function(self,y){
                if(self){
                    y = self.y;
                }else{
                    y = 0;
                }
                timeout = setTimeout(function(){
                    var lazyImg = $('img.lazy');
                    var xinpin = $('#xinpin');
                    var content = xinpin.find('.content');
                    var h = Math.abs(y)-content[0].offsetTop;
                    var baseHeight = $('#xinpinList')[0].firstElementChild.offsetHeight;
                    var itemH = baseHeight + baseHeight*0.044444;
                    var start = Math.floor(h/itemH);
                    for(var i = 0;i < lazyImg.length;i++){
                        if(lazyImg[i]){
                            if(i>=start-1 && i<start+6){
                                if(!lazyImg[i].src){
                                    $(lazyImg[i]).removeClass('imgLoad');
                                    lazyImg[i].style.visibility = 'visible';
                                    $(lazyImg[i]).on('load',function(){
                                        $(this).addClass('imgLoad');
                                    })
                                    lazyImg[i].src = lazyImg[i].dataset.original;
                                }else{
                                    $(lazyImg[i]).off('load');
                                    lazyImg[i].style.visibility = 'visible';
                                    $(lazyImg[i]).addClass('imgLoad');
                                }
                            }else{
                                $(lazyImg[i]).removeClass('imgLoad');
                                lazyImg[i].style.visibility = 'hidden';
                            }
                        }
                    }
                },200);
            }

            window.myScroll.on("scrollEnd",function(){
                var self = this;
                lazyImg(self);
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
            if($('#xinpin').find('.content').length > 0){
                lazyImg();
            }else{
                var interval = setInterval(function(){
                    if($('#xinpin').find('.content').length > 0){
                        clearInterval(interval);
                        lazyImg();
                    }
                },150)
            }

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
    "tCarousel":{
        template:"tCarousel",
        parent:"#top",
//        onBefore:function(ele,context){
//
//        },
        onComplete:function(ele,context){   //视图加入文档后所执行的回调函数
            ele.find(".adImage").each(function(){
                new AdImage($(this),1.66);
            });
            var navList=$("#carousel .navList .item");
            window.mySwipe=new Swipe(document.getElementById("carousel"),{
                startSlide: 0,
                auto: 5000,
                continuous: true,
                disableScroll: false,
                stopPropagation: false,
                callback:navList.length>=0 ? function(index, element) {
                    navList.removeClass("cur");
                    $(navList[index]).addClass("cur");
                }:undefined,
                transitionEnd: function(index, element) {}
            });
            ele.find(".imageList .item").on("tap",function(e){
                var item=$(this);
                var type =item.attr("data-type");
                var id =item.attr("data-id");
                var title=item.attr("data-title");
                var webUrl=item.attr("data-url");
                if(type=="10" || type && id ){
                    var param=context.application.getObjcDefaultParam();
                    param.parameters.type=type;
                    param.parameters.id=id;
                    param.parameters.backText=ctrl.titleName;
                    if(type=="10"){
                        param.parameters.titleText="单品特卖券";
                    }else{
                        param.parameters.titleText=title;
                    }
                    param.parameters.url=webUrl;
                    param.component.push("sharebutton-hotSale");
                    param.parameters.couponType="coupon_hotSale";
                    param.parameters.shareLink=webUrl;
                    param.parameters.shareTitle="单品特卖券";
                    param.parameters.shareDes="单品特卖券描述";
                    param.parameters.shareImg="newHotSaleGift.jpg";
                    param.level="child";
                    ctrl.openNewPageByBiz(param,context.application);
                }
                e.preventDefault();return false;
            });

        }
    },
    "tProduct":{
        template:"tProduct",
        parent:"#bottom",
//        onBefore:function(ele,context){
//
//        },
        onComplete:function(ele,context){
            ele.find(".static-wrap .adImage").each(function(){
                new AdImage($(this),1.33);
            });
            //点击top10
            ele.find(".static-wrap .top-ten-face").on("tap",function(e){
                var item=$(this);
                var id=item.attr("data-id");
                if(id){
                    var param=context.application.getObjcDefaultParam();
                    param.parameters.backText=ctrl.titleName;
                    param.parameters.titleText="top10";
                    param.parameters.id=id;
                    param.target=url.topTenProductListPage;
                    param.level="child";
                    param.target && context.application.objcOpen(param);
                }
                e.preventDefault();return false;
            });
            //点击优惠券
            ele.find(".static-wrap .coupons-face").on("tap",function(e){
                var item=$(this);
                var param=context.application.getObjcDefaultParam();
                param.parameters.backText=ctrl.titleName;
                param.parameters.titleText="优惠券";
                var _targetURL=url.couponsPage;
                param.target=_targetURL;
                param.level="child";
                param.component.push("sharebutton");
                param.parameters.couponType="coupon_general";
                param.parameters.shareLink="http://shop.xinhuan.mobi/index.php?r=coupon/newuser";
                param.parameters.shareTitle="新人购物红包 | 万款潮爆新品，新人专享低价，新欢疯狂发券，快抢！";
                param.parameters.shareDes="券可抵扣在线支付金额，新欢为你减单。转发好友，一起领券享新人特权！";
                param.parameters.shareImg="newUserGift.jpg";
                param.target && context.application.objcOpen(param);
                e.preventDefault();return false;
            });
            context.application.executeAction("updateList",{list:context.data.data.list});
        }
    },
    "tGoodsList":{
        template:"tGoodsList",   //模板id
        parent:"#xinpinList",
//        onBefore:function(ele,context){
//
//        },
        onComplete:function(ele,context){   //视图加入文档后所执行的回调函数
            var xinpinItem = ele.find(".ad .adImage");
            var brandLogo = ele.find(".brandLogo .adImage");
            setMinHeight(xinpinItem,xinpinItem[0].offsetWidth/2.21);
            setMinHeight(brandLogo,brandLogo[0].offsetWidth);
//            xinpinItem.each(function(){
//                new AdImage($(this),2.21);
//            });
            ele.find(".brandLogo .adImage").each(function(){
                new AdImage($(this),1);
            });
            ele.filter(".xinpinItem").on("tap",function(e){
//                console.log("jquery tap");
                var item=$(this);
                var type =item.attr("data-type");
                var id =item.attr("data-id");
                var title=item.attr("data-title");
                var sourceTag=item.attr("data-sourcetag");
                var pic=item.find(".ad .adImage").attr("data-ref");
                if(type && id ){
                    var param=context.application.getObjcDefaultParam();
                    param.parameters.type=type;
                    param.parameters.id=id;
                    param.parameters.backText=ctrl.titleName;
                    param.parameters.titleText=title;
                    param.parameters.specialPic=pic;
                    param.parameters.sourceTag=sourceTag;
                    param.level="child";
                    ctrl.openNewPageByBiz(param,context.application);
                }
                e.preventDefault();return false;
            });
            window.myScroll&&window.myScroll.refresh(true);
        }
    }
};
var actions={
    "main":function(context) {
        return "tBody"
    },
    "product":function(context){
        //找 banner 13
        if(context.data.data.map && context.data.data.map.notice_dis){
            context.data.data.map.notice_dis=context.data.data.map.notice_dis.toLowerCase();
        }else{
            context.data.data.map={notice_dis:"n"};
            context.data.data.map.topTen={};
        }

        var len =context.data.data.list.length;
        for (len--;len>=0;len-- ){
            var item=context.data.data.list[len];
            if(item.bannertype==13){
                context.data.data.map.topTen=item;

                break;
            }
        }
        return "tProduct";
    },
    "updateList":function(context){
        return "tGoodsList";
    },
    "carousel":function(context){
        for (var i in context.data.list){
            var item=context.data.list[i];
            switch (item.carouseltypecode){
                case 10:
                    item.dataTitle="";
                    item.dataId="";
                    break;
                case 11:
                    item.dataTitle=item.carouselgoods[0].goods.shortName;
                    item.dataId=item.carouselgoods[0].goodsid;
                    break;
                case 12:
                    item.dataTitle=item.carouselbrand[0].banner.brandname;
                    item.dataId=item.carouselbrand[0].bannerid;
                    break;
                case 33:
                    item.dataTitle=item.carouselspecial[0].banner.bannername;
                    item.dataId=item.carouselspecial[0].specialid;
                    break;
                default :
                    item.dataTitle="";
                    item.dataId="";
            }
        }
        return "tCarousel";
    }
};
var ctrl={
    currentPageIndex:1,
    pageMaxSize:6,
//    queryMode:0,
//    sortMode:0,
    titleName:"新品",
    updateGoodsList:function(context,page,joinMethod,useLoading,onComplete){
        if((page==1||!ctrl.nodata)){
            //取新品接口数据，然后显示新品界面
            urlStr=url.xinpin+"?offset="+(page-1)*ctrl.pageMaxSize+"&max="+ctrl.pageMaxSize;
            context.application.ajaxData(urlStr,"get",{},function(data){
                ctrl.calcLastTime(data.list);
//                    console.log("dataListLen:"+data.list.length);
                if(data.list&&data.list.length>0){
                    context.application.executeAction("updateList",{list:data.list,elementJoinMethod:joinMethod});
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
    openNewPageByBiz:function(param,app){
        switch (param.parameters.type){
            case "10":
                param.target=param.parameters.url;
                param.parameters.couponType="coupon_goods";
                param.component.push("sharebutton");
                //所需参数暂缺
                break;
            case "11":
                param.target=url.productDetailPage;
                break;
            case "12":
                if(param.parameters.sourceTag=="90"){
                    param.target=url.shopperProductListPage;
                }else{
                    param.target=url.bannerProductListPage;
                }

                break;
            case "33":
                param.target=url.specialProductListPage;
                break;
            default:
                param.target=undefined;
        }
        param.target && app.objcOpen(param);
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
            var item=dataList[i];
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
            //取显示名

            switch (item.bannertype){
                case 12:
                    item.dataTitle=item.bannername;
                    break;
                case 33:
                    item.dataTitle=item.bannername;
                    break;
                default :
                    item.dataTitle="";
            }
        }
    }
};
OBJC.ready(function(data){
    document.addEventListener("touchmove",function(e){e.preventDefault();return false},false);
    var app=new Application(actions,views).start("main",data);
});

/**测试*/
$(function(data){
    OBJC.executeJs("init",{backText:"首页",titleText:"热门",userId:"402888874cdae817014cdb0cb50f0048"});
});
