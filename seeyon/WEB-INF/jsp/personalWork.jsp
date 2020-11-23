<%--
 $Author: leikj $
 $Rev: 4195 $
 $Date:: 2012-09-19 18:18:30#$:

 Copyright (C) 2012 Seeyon, Inc. All rights reserved.
 This software is the proprietary information of Seeyon, Inc.
 Use is subject to license terms.
--%>
<%@ page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/common/common.jsp"%>
<html>
<head>
<title>个人事务</title>
<%--<script type="text/javascript" src="${path}/ajax.do?managerName=signetManager,spaceManager"></script>--%>
<link rel="stylesheet" type="text/css" href="/seeyon/portal/icons/default/fonts/plane/iconfont.css${ctp:resSuffix()}">
<script>
//隐藏或显示印章菜单设置
$().ready(function(){
    var curUserId = $.ctx.CurrentUser.id;
        new signetManager().findSignetByMemberId(curUserId, {
            success: function(result){
                if(result.length > 0){
                    $("#perMessageSetting").css("display","");
                }
                else{
                    $("#perMessageSetting").css("display","none");
                }
            }
        });
        new spaceManager().getSettingThemSpace({
        	success : function(list){
        		if(list.length>0){
        			$("#themSpaceSetting").show();
        		}else{
        			$("#themSpaceSetting").hide();
        		}
        	}
        });
});
</script>
<script>
$().ready(function(){
	var html = "<i class='vportal vp-personal'></i>";
    html += "<span class='nowLocation_content'>";
    html += "<a class=\"hand\" onclick=\"showMenu('"+_ctxPath+"/portal/portalController.do?method=personalInfo')\">${ctp:i18n('menu.personal.affair')}</a>";
    html += "</span>";
    // getCtpTop().showLocation(html);
    /**
    $(".file_list_four li").mouseenter(function () {
        $(this).addClass("cursor");
    }).mouseleave(function () {
        $(this).removeClass("cursor");
    });
    $(".li_t").bind("mouseover",function(){
        $(this).css("background","#ebf1dd");
    })
    $(".li_t").bind("mouseout",function(){
        $(this).css("background","");
    })**/
    if(!$.ctx.resources.contains('F12_perSignet')){
        $("#perMessageSetting").css("display","none");
    }

    var _phr = "${ctp:hasPlugin('hr')}";
    var _ihr = "${isInternal}";


    var contentList = $(".div_t");
    if(contentList.length > 0){
        for(var i = 0 ; i< contentList.length ; i = i+2){
            var contentDom = $(contentList[i]);
            var w = contentDom.width();
            if(w < 336 && contentDom.find(">div").length>4){
                contentDom.parents(".li_block").height("165px");
                if(i + 1 < contentList.length){
                    $(contentList[i+1]).parents(".li_block").height("165px");
                }
            }else if(w < 336 && i + 1 < contentList.length && $(contentList[i+1]).find(">div").length>4){
                contentDom.parents(".li_block").height("165px");
                $(contentList[i+1]).parents(".li_block").height("165px");
            }
        }
    }
});
function showCurrentHrefLocation(obj,url,bool){
    var hrefName = $(obj).html();
    var html = "<i class='vportal vp-personal'></i>";
    html += "<span class='nowLocation_content'>";
    html += "<a class=\"hand\" onclick=\"showMenu('"+_ctxPath+"/portal/portalController.do?method=personalInfo')\">${ctp:i18n('menu.personal.affair')}</a>";
    if(bool){
    	html += " &gt; <a class=\"hand\" onclick=\"showMenu('" + _ctxPath+ "/portal/portalController.do?method=personalInfoFrame&path="+url + "')\">"+hrefName+"</a>";
    }else{
    	html += " &gt; <a class=\"hand\" onclick=\"showMenu('" + _ctxPath+url + "')\">"+hrefName+"</a>";
    }
    html += "</span>";
    getCtpTop().showLocation(html);
}
function showCurrentHref(obj,url,bool,isShow,pass){
    if(pass){
        getA8Top()._pwdModify("${ctp:i18n('menu.login.pwd.modify')}");
    }else{
    	if(isShow){
            showCurrentHrefLocation(obj,url,bool);
        }
        if(bool==true||bool==undefined){
            getCtpTop().showMenu(_ctxPath + "/portal/portalController.do?method=personalInfoFrame&path="+url);
        }else{
            getCtpTop().showMenu(_ctxPath+url);
        }
    }


}
function showDocSpaceDialog(url,width,height){
	 var docSpaceDialog= getA8Top().$.dialog({
        title:"${ctp:i18n('personalInfo.storeSpace.look')}",
        transParams:{'parentWin':window},
        url: url + getA8Top().CsrfGuard.getUrlSurffix(),
        width: width,
        height: height,
        isDrag:true,
        buttons: [{
			text: "${ctp:i18n('common.button.close.label')}",
			handler: function() {
				docSpaceDialog.close();
			}
		}]
    });
}
//显示在线设备管理的对话框
function showOnlineDeviceManageDialog(url,width,height){
	 var onlineDeviceManageDialog= getA8Top().$.dialog({
      // title:"当前在线情况",
       id: 'onlineDeviceManage',
       title:"${ctp:i18n('current.online.state')}",
       transParams:{'parentWin':window},
       url: url + getA8Top().CsrfGuard.getUrlSurffix(),
       width: width,
       height: height,
       isDrag:true,
       buttons: [{
			text: "${ctp:i18n('common.button.close.label')}",
			handler: function() {
				onlineDeviceManageDialog.close();
			}
		}]
   });
}
//this,'/portal/everybodyWork.do',false,true
function openCurrentHref(obj,url,bool,isShow){
  if($.browser.msie){
    getCtpTop().open(_ctxPath+url);
  }else{
    showCurrentHref(obj,url,bool,isShow);
  }
}

//openCtpWindow({'url':'${path}/portal/spaceController.do?method=personalSpaceSetting'})
var vPortalSpaceDesignerDialog;
function editVportalSpace(){
	var dwidth= $(top).width();
    var dheight= $(top).height();
    vPortalSpaceDesignerDialog = $.dialog({
		targetWindow:top,
        id: 'vPortalSpaceDesignerDialog',
        url: '${path}/portal/spaceController.do?method=personalSpaceSetting',
        width:dwidth,
        height:dheight-110,
        title: "${ctp:i18n('portal.spacesetting.0')}",
        overflow:'hidden',
        //isHead:false,
        transParams : {
        	vPortalSpaceDesignerDialogWindowObj:window
        },
        buttons : [ {
            text : "${ctp:i18n('common.button.ok.label')}",
            isEmphasize: true,
            handler : function() {
            	var returnValue = vPortalSpaceDesignerDialog.getReturnValue({"innerButtonId":"ok"});
                if(returnValue){
                	new spaceManager().transSaveVPortalSpace(returnValue, {
                        success: function(reponseDataObj) {
                            hideMask();
                            $.messageBox({
                                'type': 0,
                                'imgType': 0,
                                'msg': $.i18n('common.successfully.saved.label'),
                                ok_fn: function() {
                                	vPortalSpaceDesignerDialog.close();
                                	//刷新当前门户
                                	if(typeof(getCtpTop().refreshPortal)!='undefined' && getCtpTop().refreshPortal){
	                                	var currentPortalUrl = _ctxPath + "/main.do?method=changeLoginAccount";
	                        	    	getCtpTop().location.href = currentPortalUrl;
                                	}
                                },
                                close_fn: function() {
                                	vPortalSpaceDesignerDialog.close();
                                	//刷新当前门户
                                	if(typeof(getCtpTop().refreshPortal)!='undefined' && getCtpTop().refreshPortal){
                                		var currentPortalUrl = _ctxPath + "/main.do?method=changeLoginAccount";
                            	    	getCtpTop().location.href = currentPortalUrl;
                                	}
                    		    }
                            });
                        },
            			error: function(e){
            				var msgJson = $.parseJSON(e);
                            $.alert(msgJson.message);
            			}
                    });
                }
            }
          }, {
            text : "${ctp:i18n('common.button.cancel.label')}",
            handler : function() {
            	vPortalSpaceDesignerDialog.close();
            }
        } ]
    });
}
function openWindow(url,windowName){
    var params = "top=0,left=0,scrollbars=yes,dialog=yes,minimizable=yes,modal=open,width=" + window.screen.width + ",height=" + window.screen.height + ",resizable=yes";
    return window.open(url,windowName,params);
}
var vPortalWindowDialog= null;
function openVPortalWindow(type){
	var windowName="";
	if(type==0){
		windowName="${ctp:i18n('portal.personportal')}";
	}else if(type==1){
		windowName="${ctp:i18n('space.default.personal.label')}";
	}else if(type==2){
		windowName="${ctp:i18n('portal.system.menu.portalset')}";
	}else{
		windowName="${ctp:i18n('portal.system.menu.spaceset')}";
	}
	var securityType=type==2||type==3?1:0;
	var selected=type==0||type==2?0:1;
/*     if (vPortalWindow && !vPortalWindow.closed) {
    	vPortalWindow.alert($.i18n("window.already.exit.js"));
    }else{
    	vPortalWindow= openWindow("${path}/portal/portalDesigner.do?method=vPortalEngineIndex&securityType="+securityType+"&selected="+selected,windowName);
    } */
    var dwidth= $(top).width();
    var dheight= $(top).height();
    vPortalWindowDialog = $.dialog({
		targetWindow:top,
        id: 'vPortalWindowDialog',
        url: "${path}/portal/portalDesigner.do?method=vPortalEngineIndex&securityType="+securityType+"&selected="+selected+"&from=dialog",
        width:dwidth,
        height:dheight,
        title: windowName,
        overflow:'hidden',
        transParams : {
        	vPortalWindowDialogObj:window
        },closeParam : {
            'show' : true
            ,handler : function(){
            	if(typeof(getCtpTop().refreshPortal)!='undefined' && getCtpTop().refreshPortal){
                    if(getCtpTop()["removeOnbeforeunload"]!=null){
                         getCtpTop()["removeOnbeforeunload"]();
                    }
                    var currentPortalUrl = _ctxPath + "/main.do?method=changeLoginAccount";
        	    	getCtpTop().location.href = currentPortalUrl;
            	}
            }
        }
    });
}
</script>
    <style type="text/css">
        body{
            background-color: #f1f2f4;
        }
        .list_ul {
            overflow: hidden;
            margin: 20px;
        }
        .li_t{
            float: left;
            overflow: hidden;
            width: 50%;
        }
        .li_t .li_block{
            margin: 10px;
            background-color: #FFFFFF;
            height: 130px;
            border-radius: 8px;
            position: relative;
        }
        .li_t .left_div{
            float: left;
            width: 90px;
            height: 100%;
        }
        .li_t .left_div .img_div{
            margin: 40px auto 0 auto;
            width: 50px;
            height: 50px;
        }
        .li_t .set_content .title_div{
            line-height: 16px;
            font-size: 16px;
            color: #111111;
            text-align: left;
            margin-top: 20px;
            margin-left: 10px;
        }
        .li_t .left_div .img_div span{
            font-size: 50px;
            color: #cbcfd5;
        }
        .li_t .set_content{
            position: absolute;
            height: 100%;
            right: 0;
            top: 0;
            left: 90px;
        }
        .div_t{
            margin-top: 15px;
        }
        .menu_btn_div{
            float: left;
            background: #FFFFFF;
            border: 1px solid #1f85ec;
            border-radius: 13px;
            min-width: 50px;
            max-width: 300px;
            padding: 0 10px;
            height: 24px;
            line-height: 24px;
            text-align: center;
            font-size: 12px;
            color: #1f85ec;
            margin-right: 15px;
            margin-bottom: 10px;
            cursor: pointer;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
        .menu_btn_div:hover{
            background-color: #1f85ec;
            color: #FFFFFF;
        }
    </style>
</head>
<body class="set_page_bg2">
<div class="list_ul" id="list_ul">
    <!-- 应用设置 -->
    <div class="li_t">
        <div class="li_block">
            <div id="individual_template" class="left_div">
                <div class="img_div">
                    <%--<img src="${path}/skin/dist/images/set1.png${ctp:resSuffix()}">--%>
                    <span class="vportal vp-application-settings"></span>
                </div>
            </div>
            <div class="set_content">
                <div class="title_div">${ctp:i18n('menu.personalSet.AppSet')}</div>
                <div class="div_t">
                    <!-- 代理人设置 -->
                   <%-- <c:if test="${isInternal}">
                        <div class="menu_btn_div" onclick="showCurrentHref(this,'/agent.do?method=agentFrame',false,true)">${ctp:i18n('menu.individual.agent')}</div>
                    </c:if> --%>
                    <!-- 个人模板设置 -->
                    <div class="menu_btn_div" onclick="showCurrentHref(this,'/mytemplate.do?method=myTemplate',false,true)">${ctp:i18n('menu.individual.template.set')}</div>
                    <!-- 消息提示设置 -->
                    <div class="menu_btn_div" onclick="showCurrentHref(this,'/message.do?method=showMessageSetting',false,true)">${ctp:i18n('message.setting.title')}</div>
                    <c:if test="${ctp:hasPlugin('edoc')}">
                    <div class="menu_btn_div" onclick="showCurrentHref(this,'/govdoc/open.do?method=govdocview',false,true)">${ctp:i18n('systemswitch.archives.govdocview')}</div>
                    </c:if>
                    <%--工作交接 --%>
                  <%--  <div class="menu_btn_div" onclick="showCurrentHref(this,'/handover.do?method=handoverConfigList',false,true)">${ctp:i18n('handover.menu.name.js')}</div>
				  --%>
                </div>
            </div>
        </div>
    </div>
    <!-- 关联应用设置 -->
    <%--<div class="li_t">
        <div class="li_block">
            <div id="peoplerelate_options" class="left_div" >
                <div class="img_div">
                    &lt;%&ndash;<img src="${path}/skin/dist/images/set2.png${ctp:resSuffix()}">&ndash;%&gt;
                    <span class="vportal vp-association-application-settings"></span>
                </div>
            </div>
            <div class="set_content">
                <div class="title_div">${ctp:i18n('menu.application.setting')}</div>
                <div class="div_t">
                    <!-- 关联人员 -->
                    <div class="menu_btn_div" onclick="showCurrentHref(this,'/relateMember.do?method=relate',false,true)">${ctp:i18n('menu.peoplerelate.info')}</div>
                    <!-- 关联项目 -->
                    <!-- <tr>
                        <td class="file_name" onclick="showCurrentHref(this,'/project.do?method=myTemplateBorderMain',false,true)">${ctp:i18n('menu.projecerelate.info')}</td>
                    </tr>   -->
                    <!-- 关联系统 -->
                    <div class="menu_btn_div" onclick="showCurrentHref(this,'/portal/linkSystemController.do?method=userLinkMain',false,true)">${ctp:i18n('menu.relateSystem.info')}</div>
                    <c:if test="${ctp:hasPlugin('everybodyWork')}">
                        <div class="menu_btn_div" onclick="openCurrentHref(this,'/portal/everybodyWork.do',false,true)">${ctp:i18n('everybodyWork.button.label') }</div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>--%>

    <!-- 首页设置 -->
  <%--  <div class="li_t">
        <div class="li_block">
            <div id="personalSetting_message" class="left_div">
                <div class="img_div">
                    &lt;%&ndash;<img src="${path}/skin/dist/images/set5.png${ctp:resSuffix()}">&ndash;%&gt;
                    <span class="vportal vp-portal-settings"></span>
                </div>
            </div>
            <div class="set_content">
                <div class="title_div">${ctp:i18n('menu.portal.setting')}</div>
                <div class="div_t">
                    <div class="menu_btn_div" onclick="openVPortalWindow(0);">${ctp:i18n("menu.personalset.portalset")}</div>
                    <div class="menu_btn_div" onclick="openVPortalWindow(1);">${ctp:i18n("menu.personalset.spaceset")}</div>
                    <c:if test="${haveManagementPortal }">
                        <div class="menu_btn_div" onclick="openVPortalWindow(2);">${ctp:i18n("menu.personalset.sysportalset")}</div>
                    </c:if>
                    <c:if test="${haveManagementSpace }">
                        <div class="menu_btn_div" onclick="openVPortalWindow(3);">${ctp:i18n("menu.personalset.sysspaceset")}</div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    --%>
    <!-- HR管理 -->
    <c:if test="${ctp:hasPlugin('hr') && isInternal}">
        <c:if test="${(salaryEnabled || ctp:hasPlugin('attendance'))}">
            <div class="li_t">
                <div class="li_block">
                    <div id="peoplerelate_options" class="left_div">
                        <div class="img_div">
                            <%--<img src="${path}/skin/dist/images/set3.png${ctp:resSuffix()}">--%>
                            <span class="vportal vp-HR-management"></span>
                        </div>
                    </div>
                    <div class="set_content">
                        <div class="title_div">${ctp:i18n('menu.personalSet.HRManager')}</div>
                        <div class="div_t">
                            <!-- 薪资查看 -->
                            <c:if test="${salaryEnabled}">
                                <div class="menu_btn_div" onclick="showCurrentHref(this,'/hrViewSalary.do?method=viewSalary',false,true)">${ctp:i18n('menu.hr.salary.show')}</div>
                            </c:if>
                            <!-- 个人考勤 -->
                            <c:if test="${ctp:hasPlugin('attendance')}">
                                <div class="menu_btn_div" onclick="showCurrentHref(this,'/attendance/attendance.do?method=intoMyAttendance',false,true)">${ctp:i18n('menu.hr.personal.attendance.manager')}</div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </c:if>
    <!-- 密码和帐号管理 -->
  <%--  <div class="li_t">
        <div class="li_block">
            <div id="passage_Setting" class="left_div" >
                <div class="img_div">
                    &lt;%&ndash;<img src="${path}/skin/dist/images/set6.png${ctp:resSuffix()}">&ndash;%&gt;
                    <span class="vportal vp-mimaanquanshezhi"></span>
                </div>
            </div>
            <div class="set_content">
                <div class="title_div">${ctp:i18n('menu.personalset.passwordset')}</div>
                <div class="div_t" >
                    <!-- 登录密码修改 -->
                    <c:if test="${personModifyPwd}">
                        <div class="menu_btn_div" onclick="showCurrentHref(this,'/individualManager.do?method=managerFrame',true,true,true)">${ctp:i18n('menu.login.pwd.modify')}</div>
                    </c:if>
                    <!-- 印章密码管理 -->
                    <div class="menu_btn_div" onclick="showCurrentHref(this,'/signet.do?method=modifyPasswordSignet',false,true)">${ctp:i18n('menu.print.cipher.manage')}</div>
                    <!-- NC账号设置 -->
                    <c:if test="${ctp:hasPlugin('nc')||ctp:hasPlugin('ncsupplychain')||ctp:hasPlugin('ncfinance')||ctp:hasPlugin('ncehr')||ctp:hasPlugin('ncfdc')}">
                        <div class="menu_btn_div" onclick="showCurrentHref(this,'/ncUserMapper.do?method=viewBindingMapper',false,true)">${ctp:i18n('nc.user.mapper')}</div>
                    </c:if>
                    <!-- cip 设置 -->
                    <c:if test="${ctp:hasPlugin('applink')}">
                        <c:if test="${cipEnabled == true }">
                            <div class="menu_btn_div" onclick="showCurrentHref(this,'/cip/userBindingController.do?method=bindingMySelf',false,true)">${ctp:i18n('cip.service.binding.path.person')}</div>
                        </c:if>
                    </c:if>
                </div>
            </div>
        </div>
    </div>--%>

    <!-- 其他设置 -->
    <div class="li_t">
        <div class="li_block">
            <div id="personalSetting_message" class="left_div" >
                <div class="img_div">
                    <%--<img src="${path}/skin/dist/images/set6.png${ctp:resSuffix()}">--%>
                    <span class="vportal vp-setting"></span>
                </div>
            </div>
            <div class="set_content">
                <div class="title_div">${ctp:i18n('personal.message.setting')}</div>
                <div class="div_t" >
                    <!-- 查看存储空间 -->
                    <div class="menu_btn_div" onclick="showDocSpaceDialog('docSpace.do?method=storeSpaceLook',490,230)">${ctp:i18n('personalInfo.storeSpace.look')}</div>
                    <!-- 在线管理 -->
                    <div class="menu_btn_div" onclick="showOnlineDeviceManageDialog('individualManager.do?method=showOnlineDevice',490,230)">${ctp:i18n('online.device.manage')}</div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>