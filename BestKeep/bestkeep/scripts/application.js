function Application(actions,views){
    var self=this;
    self.actionSet=actions;
    self.viewSet=views;
    self.start=function(welcomeAction,initParam){
        self.executeAction(welcomeAction,initParam);
    };
    self.executeAction=function(actionKey,param){
        var context={
            application:self,
            parameter:param,
            data:param
        };
        var ac=self.actionSet[actionKey];
        if(ac){
            context.action=ac;
            var result=ac(context);
            if(result){
                self.executeView(result,context);
            }
        }
    };
    self.executeView=function(result,context){
        var view= self.viewSet[result];
        if(view){
            context.view=view;
            self.createView(view,context);
        }
    };
    self.createView=function(view,context){
        var ele=self.createElement(view.template,context.data);
        var parent=view.parent||"#view";
        self.executeViewBeforeCallback(view,ele,context);
        if(context.parameter.elementJoinMethod=="html"){
            $(parent).html(ele).addClass("loaded");
        }else{
            $(parent).append(ele).addClass("loaded");
        }
        self.executeViewCallback(view,ele,context);
    };
    self.executeViewBeforeCallback=function(view,ele,context){
        if(view){
            if(view.include){
                for (var i in view.include){
                    if(view.include[i]){
                        self.executeViewBeforeCallback(self.viewSet[view.include[i]],ele,context);
                    }
                }
            }
            view.onBefore && view.onBefore(ele,context);
        }
    };
    self.executeViewCallback=function(view,ele,context){
        if(view){
            if(view.include){
                for (var i in view.include){
                    if(view.include[i]){
                        self.executeViewCallback(self.viewSet[view.include[i]],ele,context);
                    }
                }
            }
            view.onComplete && view.onComplete(ele,context);
        }
    };
    self.createElement=function(tid,param){
        var html = template(tid, param);
        return $(html);
    };
    self.objcMessage=function(param,success,before){
        if(OBJC && param){
            OBJC.executeNative(OBJC.config.method.MESSAGE.name,param,success,before)
        }
    };
    self.objcOpen=function(param,success,before){
        if(OBJC && param){
            OBJC.executeNative(OBJC.config.method.OPEN.name,param,success,before)
        }
    };
    self.objcClose=function(param,before){
        if(OBJC && param){
            OBJC.executeNative(OBJC.config.method.CLOSE.name,param,undefined,before)
        }
    };
    self.objcSetCatchData=function(key,value){
        if(OBJC && key){
            var param={
                target:key,          //缓存key值
                parameters:value,  //缓存value值
                level:"set"         //操作 get/set
            };
            OBJC.executeNative(OBJC.config.method.DATACATCH.name,param,undefined,undefined);
        }
    };
    self.objcGetCatchData=function(key,success,before){
        if(OBJC && key){
            var param={
                target:key,          //缓存key值
                parameters:value,  //缓存value值
                level:"get"         //操作 get/set
            };
            OBJC.executeNative(OBJC.config.method.DATACATCH.name,param,success,before);
        }
    };
    self.getObjcDefaultParam=function(){
        return OBJC.getDefaultParam();
    };
    self.ajaxData=function(url,method,param,success,error,usePup,complete){
        var pup;
        if(usePup && !self.loadPup){
            pup=$("<div class='pupLoading'><span></span></div>");
        }
        $.ajax({
            type:method || "GET",
            url:url,
            data:method=="get"?param:JSON.stringify(param),
            dataType:"json",
            timeout:20000,
            contentType:"application/json",
            beforeSend:function(){
                if(usePup&&!self.loadPup){
                    self.loadPup=pup;
                    $("#main").append(self.loadPup);
                    setTimeout(function(){
                        self.loadPup.addClass("in");
                    },0)

                }

            },
            success:function(data){
                setTimeout(function(){
                    success && success(data);
                },0);
            },
            error:function(){
                setTimeout(function(){
                    error && error();
                },0);
                self.loadPup&&self.loadPup.addClass("error");
            },
            complete:function(){
                complete&&complete();
                setTimeout(function(){
                    self.loadPup&&self.loadPup.removeClass("in");
                    setTimeout(function(){
                        self.loadPup&&self.loadPup.remove();
                        self.loadPup=undefined;
                    },300);
                },1000);
            }
        });
    }
}

/** AdImage*/
function AdImage(ele,whrote,scroller){
    setTimeout(function(){
        var ref=ele.attr("data-ref");
//    ref=ref.indexOf("http://")!=-1? ref:"http://"+ref;
        whrote=whrote||"auto";
        if(whrote=="auto"){
            ele.height("auto");
        }else if(whrote=="full"){
            ele.height("100%");
            ele.css("overflow","hidden");
        }else{
            ele.css("minHeight",Math.floor(ele.width()/whrote)+"px");
        }
        ele.closest("li").addClass("inited");
        if(ref){
            var image=new Image();
            image.onload=function(){
                ele.html(image).addClass("loaded");
                if(window.freshScrollTimer){
                    clearTimeout(window.freshScrollTimer);
                    window.freshScrollTimer=undefined;
                }
                window.freshScrollTimer=setTimeout(function(){
                    scroller=scroller || window.myScroll;
                    scroller&& scroller.refresh(true);
                    window.freshScrollTimer=undefined;
                })
            };
            image.src=ref;
        }else{
            ele.addClass("noImage");
        }
    },0);
}
//设置图片容器高度
function setMinHeight(ele,height){
    ele.height(height+"px");

    ele.closest("li").addClass("inited");
}
function XHTimer(dom,remainingSeconds){
    var beginTime=new Date().getTime();
    var minite=60,hour=minite*60,day=hour*24;
    var timer=setInterval(function(){
        var currentSeconds=Math.floor(remainingSeconds-(new Date().getTime()-beginTime)/1000);
        if(currentSeconds<1){clearInterval(timer);return false;}
        var timeStr="剩余";
        var days=Math.floor(currentSeconds/day);
        currentSeconds-=days*day;
        var hours=Math.floor(currentSeconds/hour);
        currentSeconds-=hours*hour;
        var minites=Math.floor(currentSeconds/minite);
        var seconds=Math.floor(currentSeconds-minites*minite);
        timeStr+=days? days+"天 ":" ";
        timeStr+=hours<10? "0"+hours+":":hours+":";
        timeStr+=minites<10? "0"+minites+":":minites+":";
        timeStr+=seconds<10? "0"+seconds:seconds;
        dom.text(timeStr);
    },1000);
}
/** Array 扩展*/
Array.prototype.contains = function(item){
    for(i=0;i<this.length;i++){
        if(this[i]==item){return true;}
    }
    return false;
};
function Tip(content){
    var pup=$("<div class='pupLoading tip'><span>"+(content||"")+"</span></div>");
    if(window.pupTip==undefined){
        $("#main").append(pup);
        window.pupTip=pup;
        setTimeout(function(){
            pup.addClass("in");
            setTimeout(function(){
                pup.removeClass("in");
                setTimeout(function(){
                    pup.remove();
                    window.pupTip=undefined;
                },500);
            },2000);
        },0)
    }

}