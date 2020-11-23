

<!-- 宽尺寸的logo -->
<script id="tpl-wideLogo" type="text/html">
    <div class="wideLogo {{# if(document.getElementById('concurrentAccountDiv') == null){ }} noConcurrentAccount {{# }else{ }} hasConcurrentAccount {{# } }}" id="logoArea"{{# if(!vPortal.isDesigner){ }} onclick="javascript:refreshCurrentSpace()"{{#} }}>
        <div class="logo">
            {{# if(d && d.logoShowType){ }}
            {{# if(d.logoShowType == "1" && d.logo !== ""){ }}
            <img height="{{ d.logoHeight }}" src="{{ d.logo }}">
            {{#}else{ }}
            <img src="{{ d.logo }}">
            {{#} }}
            {{#} }}
        </div>
        <div class="companyNames">
            {{# if(d.groupShortName != "" || d.accountShortName !="" ){ }}
            <div class="cnName">
                {{# if(d.groupShortName != ""){ }}
                <span id="groupShortName" title="{{ d.groupShortName }}" class="groupName">{{ d.groupShortName }}</span>
                {{# } }}
                {{# if(d.accountShortName != ""){ }}
                <span id="accountShortName" title="{{ d.accountShortName }}" class="accountShortName">{{ d.accountShortName }}</span>
                {{# } }}
            </div>
            {{# } }}
            {{# if(d.accountSecondName !="" ){ }}
            <div class="enName">
                <span id="accountSecondName" title="{{ d.accountSecondName }}" class="accountShortName">{{ d.accountSecondName }}</span>
            </div>
            {{# } }}
        </div>
    </div>
</script>

<!--切换兼职单位-->
<script id="tpl-concurrentAccount" type="text/html">
    {{# if( (vPortal.subPortal && vPortal.subPortal !== "true") || vPortal.portalId == "" || vPortal.isThemeShow ){ }}
    {{#
    var _accountArr = d.accountArr?d.accountArr:d;
    var _accountFontSize = d.fontSize?d.fontSize:12;
    var _accountTextColor = d.fontColor?d.fontColor:'';
    var _accountIconColor = d.iconColor?d.iconColor:'';
    }}
    <div class="concurrentAccount">
        <div class="concurrentArrow" onclick="javascript:vPortalMainFrameElements.concurrentAccount.showConcurrentList(event)"><i style="color: {{_accountIconColor}};"  id="concurrentAccountDiv" class="vportal vp-arrow-down"></i></div>
        <ul class="autoHideElement" style="color:{{_accountTextColor}}" id="concurrentList" onmouseleave="javascript:vPortalMainFrameElements.concurrentAccount.hideConcurrentList()">
            {{# for(var i = 0, len = _accountArr.length; i < len; i++){ }}
            <li title = {{ _accountArr[i].shortName }} style="font-size: {{_accountFontSize + 'px' }}; " onclick="javascript:vPortalMainFrameElements.concurrentAccount.changeConcurrent('{{ _accountArr[i].id }}')">{{ _accountArr[i].shortName }}</li>
            {{# } }}
    </div>
    {{# } }}
</script>

<!-- 顶部右侧操作区 -->
<script id="tpl-topRightsystemOperation" type="text/html">
    {{# if(vPortal.subPortal!="true"){ }}
    <div class="topRightsystemOperation" id="topRightsystemOperationWidth" style="{{# if( vPortal.themeHotspots.skin && vPortal.themeHotspots.skin.topRightsystemOperationBgc){  }} background-color:{{=vPortal.themeHotspots.skin.topRightsystemOperationBgc}}   {{# } }}">
        <ul class="topIco">
            {{# if(document.getElementById("onlineNumArea") == null){ }}
            <li class="account3in1">
                {{#  var _currentState = vPortal.currentState === "" ? "0" : vPortal.currentState; }}
                <div class="onlineNum hand"  style="{{# if(d.btnonlineNum != '1'){ }}display: none{{# } }}" class="onlineNumArea" onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.onlineMember();"><span id="onlineNum">{{ vPortal.onlineNumber }}</span>{{ $.i18n('common.people.label') }}</div>
                <div class="smallHead" onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.showPersonCenter()"><img id="memberImageUrl" width="22" height="22" src="{{ vPortal.memberImageUrl }}"></div>
                <em></em>
                {{# if(vPortal.smsSendEnabled == true){}}
                <i class="vportal vp-message" onclick="sendSMSV3X();"></i>
                {{# } }}
            </li>
            {{# } }}
            <li class="signBtn" title="{{=$.i18n('menu.sign.label')}}" style="{{# if(d.btnSign != '1' || vPortal.cardEnabled==false){ }}display: none{{# } }}">
                <span onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.onlineCardClick();" style="{{# if(d.btnSignStyle == 'icon'){ }}display: none{{# } }}">{{=$.i18n("menu.sign.label")}}</span>
                <i onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.onlineCardClick();" class="vportal vp-signIn" style="{{# if(d.btnSignStyle != 'icon'){ }}display: none{{# } }}"></i>
                <em></em>
            </li>
            <li class="appIco" title="{{=$.i18n('portal.hotspot.button.appcenter.label')}}" style="{{# if(d.btnAppCenter != '1'){ }}display: none{{# } }}"  onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.appcenterClick();"><i class="vportal vp-XXApp"></i><em></em></li>
            <li class="searchIco"  title="{{=$.i18n('menu.search.label')}}" style="{{# if(d.btnSearch != '1' || vPortal.searchEnabled==false){ }}display: none{{# } }}"><i onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.searchOpen();" class="vportal vp-search-large"></i>
                <em></em>
                <div class="searchContainer" id="searchContainer">
                    <i onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.searchClose();" class="vportal vp-close searchClose"></i>
                    <input type="text" maxlength="20" placeholder="{{=$.i18n("portal.index.search.txt")}}" id="searchAreaInput" onfocus="javascript:autoCompletionFun.action(this,'autoCompletion')">
                    <span class="common_button topRightSearchButton" onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.search('searchAreaInput');">{{=$.i18n("menu.search.label")}}</span>
                    <div id="autoCompletion" class="autoCompletion"></div>
                </div>
            </li>
            <!-- <li class="backIco" style="{{# if(d.btnBack != '1'){ }}display: none{{# } }} "><i class="vportal vp-back"></i><em></em></li>
            <li class="forwardIco" style="{{# if(d.btnGo != '1'){ }}display: none{{# } }} "><i class="vportal vp-forward"></i><em></em></li> -->
            <li class="refreshIco" title="{{=$.i18n('menu.refresh.label')}}" onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.refreshPageClick()" style="{{# if(d.btnRefresh != '1'){ }}display: none{{# } }} "><i class="vportal vp-refresh"></i><em></em></li>
            <li class="messageIco" title="{{=$.i18n('menu.ucMsg.label')}}" style="{{# if(d.btnMessage != '1' || vPortal.ucEnabled != 'true' ){ }}display: none{{# } }}" onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.msgClick();"><i class="vportal vp-msg"></i><em></em></li>

            <li class="onlineServiceIco" title="{{=$.i18n('menu.onlineService.label')}}" style="{{# if(d.btnonlineService != '1' || vPortal.OnlineCustomerServiceEnabled != true ){ }}display: none{{# } }}"onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.onlineServiceClick();"><i class="vportal vp-OnlineService"></i><em></em></li>
            <li class="settingIco" onmouseover="vPortalMainFrameElements.topRightsystemOperation.showPersonContainer()" onmouseleave="vPortalMainFrameElements.topRightsystemOperation.hidePersonContainer()">
                <i class="vportal vp-setting"></i>
                <iframe id="personContainer_iframe" allowtransparency="true" class="personContainer_iframe" frameborder="0"></iframe>
                <div class="personContainer" id="personContainer">
                    <ul class="pushdownSecond">
                        <li id="skin" title="{{=$.i18n('portal.changeSkin.lable')}}" style="{{# if(d.btnHomeSet != '1'){ }}display: none{{# } }}" onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.showSkinPanle();getCtpTop().openSkinPanle = '1';">{{=$.i18n("portal.changeSkin.lable")}}</li>
                        <li id="mySet" title="{{=$.i18n('menu.personal.affair')}}" onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.mySetClick();">{{=$.i18n("menu.personal.affair")}}</li>
                        {{# if(vPortal.locale == "zh_CN" ){ }}
                        <li id="productView_btn" title="{{=$.i18n('menu.productNavigation.label')}}" style="display: none" onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.productViewClick();">{{=$.i18n("menu.productNavigation.label")}}</li>
                        {{# } }}
                        <li id="viewSalary" title="{{=$.i18n('menu.hr.salary.show')}}" style="{{# if(d.btnSalaryView != '1' || vPortal.salaryEnabled==false){ }}display: none{{# } }}" onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.viewSalaryClick();">{{=$.i18n("menu.hr.salary.show")}}</li>
                        <li id="about" title="{{=$.i18n('product.about.title')}}"  style="{{# if(d.btnAbout == '0'){ }}display: none{{# } }}" onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.showAbout();">{{=$.i18n("product.about.title")}}</li>
                        <li id="logout" title="{{=$.i18n('seeyon.top.close.alt')}}" onclick="javascript:vPortalMainFrameElements.topRightsystemOperation.logoutClick();">{{=$.i18n("seeyon.top.close.alt")}}</li>
                    </ul>
                </div>
            </li>
        </ul>
    </div>
    {{# }else if(top.isVJTop){ }}
    <div class="topRightsystemOperation" id="topRightsystemOperationWidth" style="{{# if( vPortal.themeHotspots.skin && vPortal.themeHotspots.skin.topRightsystemOperationBgc){  }} background-color:{{=vPortal.themeHotspots.skin.topRightsystemOperationBgc}}; padding-right: 0; margin-right: 13px; {{# } }}">
        <ul class="topIco">
            <li class="messageIco" title="{{=$.i18n('portal.icons.name160')}}" onclick="javascript:top.showHideMB()" style="text-align: center;"><i class="vportal vp-message"></i><em></em></li>
            <li class="settingIco" onmouseover="vPortalMainFrameElements.topRightsystemOperation.showPersonContainer()" onmouseleave="vPortalMainFrameElements.topRightsystemOperation.hidePersonContainer()" style="text-align: center;">
                <i class="vportal vp-setting"></i>
                <iframe id="personContainer_iframe" class="personContainer_iframe" frameborder="0"></iframe>
                <div class="personContainer" id="personContainer">
                    <ul class="pushdownSecond">
                        <li id="mySet" title="{{=$.i18n('menu.password.modify')}}" onclick="javascript:top.modifyPwd()">{{=$.i18n('menu.password.modify')}}</li>
                        <li id="logout" title="{{=$.i18n('seeyon.top.close.alt')}}" onclick="javascript:top.logout()">{{=$.i18n("seeyon.top.close.alt")}}</li>
                    </ul>
                </div>
            </li>
        </ul>
    </div>
    <div></div>
    {{# } }}
</script>

<!-- 顶部中间的空间导航 -->
<script id="tpl-topCenterNav" type="text/html">
    {{# if(vPortal.themeHotspots && vPortal.themeHotspots.topCenterSpaceNav && vPortal.themeHotspots.topCenterSpaceNav!=undefined && vPortal.themeHotspots.topCenterSpaceNav.portalNavMax !== null){ var maxShowedNav = Number(vPortal.themeHotspots.topCenterSpaceNav.portalNavMax) } else{ var maxShowedNav = 3; } }}
    {{#
    /** 自定义的最大宽度 **/
    var navMaxWidth = false;
    var extClass = '';
    if(vPortal.layoutFunction && vPortal.layoutFunction.navAutoWidth){
    var _widthsArr = vPortalMainFrameElements.topCenterNav.maxShowedNav(d);
    maxShowedNav = _widthsArr.maxShowedNav;
    navMaxWidth = _widthsArr.navMaxWidth;
    extClass= 'navAutoWidth';
    }
    }}
    {{# var len = d.length > maxShowedNav ? maxShowedNav : d.length; }}

    {{# if( !(len == 1 && vPortal.portalType==3) ){ }}
    <div class="topCenterNav navHotspotsArea{{# if(vPortal.subPortal=='true'){ }} noRightTopCenterNav{{#} }} {{extClass}}{{# if(top.isVJTop){ }}vjTopCenter{{# } }}">
        <ul class="showedSpaceNav" id="showedNav">
            {{# for(var i = 0; i < len; i++){ }}
            {{# var navName = d[i]["navName"] || d[i]["spaceName"];}}
            {{# navName = navName.escapeHTML(true) }}
            {{# var navId = d[i]["id"] || d[i]["spaceId"];}}
            {{#
            var _navWidth = 0;
            if(maxShowedNav >= 3){
            _navWidth = 100;
            }else{
            _navWidth = 400;
            }
            /** 自定义的最大宽度 以这个为准 **/
            if(navMaxWidth){
            _navWidth = navMaxWidth;
            }

            }}
            <li id="spaceLi_{{ navId }}" {{#  if(len == 1 && vPortal.portalType==3) { }} style="display:none;max-width: {{ _navWidth }}px" {{# }else{ }}style = "max-width:{{ _navWidth }}px"{{# } }} {{#  if(i == 0) { }} class="current" {{# } }} title="{{ navName }}" onclick="javascript:vPortalMainFrameElements.topCenterNav.showNavigation({{i}},this)">
                <div class="navName">{{ navName }}</div>
                <div class="navBottomBorder"></div>
            </li>
            {{# } }}
        </ul>
        {{# if(d.length > maxShowedNav){ }}
        <div class="moreSpaceNav" id="moreSpaceNav" onmouseenter="javascript:showMoreSpaceNavList(this)" onmouseleave="hideMoreSpaceNavList(this)">
            <div class="moreSpaceNavArrow"><i class="vportal vp-arrow-down-serif"></i></div>
            <iframe id="topCenterNav_iframe" class="topCenterNav_iframe" frameborder="0"></iframe>
            <div class="moreSpaceNavList" id="moreSpaceNavList">
                <ul>
                    {{# for(var i = maxShowedNav; i < d.length; i++){ }}
                    {{# var navId = d[i]["id"] || d[i]["spaceId"];}}
                    {{# var navName = d[i]["navName"] || d[i]["spaceName"];}}
                    {{# navName = navName.escapeHTML(true) }}
                    <li id="spaceLi_{{ navId }}" title="{{ navName }}" onclick="javascript:vPortalMainFrameElements.topCenterNav.showNavigation({{i}},this)">
                        {{# if(d[i]["icon"] && (d[i]["icon"].indexOf("/fileUpload.do") > -1 || d[i]["icon"].indexOf("/m3/apps")>-1 )){ }}
                        <div class="navIcon"><img src="{{ _ctxPath + d[i]['icon'] }}" /></div>
                        {{#}else if(d[i]["icon"]){ }}
                        <div class="navIcon"><i class="vportal vp-{{ d[i]['icon'] }}"></i></div>
                        {{# } }}
                        <div class="navName">{{ navName }}</div>
                    </li>
                    {{# } }}
                    <div class="clearFix"></div>
                </ul>
                <div class="square"></div>
            </div>
        </div>
        {{# } }}
        <div class="clearFix"></div>
    </div>
    {{# } }}
</script>

<!-- 左侧大尺寸头像 -->
<script id="tpl-largeHead" type="text/html">
    <div class="largeHead"{{# if(!top.isVJTop){ }} onclick="javascript:showPersonCenter()" style="cursor: pointer;"{{# } }}><img id="memberImageUrl" src="{{ d }}"></div>
</script>

<!-- 在线状态 -->
<script id="tpl-onlineStatus" type="text/html">
    <div class="onlineStatus"><i class="vportal vp-online{{ d }}"></i></div>
</script>

<!-- 在线人数 -->
<script id="tpl-onlineNum" type="text/html">
    {{# if(!top.isVJTop){ }}
    <div class="onlineNum hand" ><span onclick="javascript:vPortalMainFrameElements.onlineNum.onlineMember();"><strong id="onlineNum">{{ vPortal.onlineNumber }}</strong>{{ $.i18n('common.people.label') }}</span> {{# if(vPortal.smsSendEnabled == true){}} <i class="vportal vp-message" onclick="sendSMSV3X();"></i>{{# } }}</div>
    {{# } }}
</script>

<!-- 顶部快捷菜单 -->
<script id="tpl-topShortcutNav" type="text/html">
    {{# if(d.currentNavGroupArray[0]["items"].length > 0){ }}
    <div class="topShortcutNav shortcutNav lev1 lev" id="shortcutNav">
        <ul class="topShortcutNavContainer">
            <li class="lev1Li">
                <div class="lev1Title navTitleName" title="{{ d.currentNavGroupArray[0].name }}" onmouseenter="javascript:topNavShowChildAndFixPostion(this,'50')" onmouseleave="javascript:topNavHideChild(event,this)"><span class="navText"><i class="vportal vp-{{ d.currentNavGroupArray[0].icon }}"></i></span></div>
                <div class="lev2 lev" onmouseenter="javascript:topNavShowThisLev(this)" onmouseleave="javascript:topNavHideThisLev(this)">
                    <div class="navScrollUp" onselectstart="return false" onclick="javascript:navScrollUp(this,'50')"><i class="vportal vp-arrow-up-serif"></i></div>
                    <ul class="lev2Ul">
                        {{# for(var j = 0, _len = d.currentNavGroupArray[0]["items"].length; j < _len; j++){ }}
                        <li class="lev2Li">
                            <div class="lev2Title navTitleName" title="{{ d.currentNavGroupArray[0]['items'][j].name }}" {{# if (d.currentNavGroupArray[0].items[j].url != undefined) { }} onclick="javascript:showMenu('{{_ctxPath + d.currentNavGroupArray[0].items[j].url }}','{{ d.currentNavGroupArray[0].items[j].id }}','{{ d.currentNavGroupArray[0].items[j].target }}','{{ d.currentNavGroupArray[0].items[j].resourceCode }}',this)"{{# } }} onmouseenter="javascript:topNavShowChildAndFixPostion(this,'50')" onmouseleave="javascript:topNavHideChild(event,this)"><i class="vportal vp-{{ d.currentNavGroupArray[0].items[j].icon }}"></i><span class="navText">{{ d.currentNavGroupArray[0].items[j].name }}</span></div>
                        </li>
                        {{# } }}
                    </ul>
                    <div class="navScrollDown" onselectstart="return false" onclick="javascript:navScrollDown(this,'50')"><i class="vportal vp-arrow-down-serif"></i></div>
                </div>
            </li>
        </ul>
    </div>
    {{# } }}
</script>

<!-- 顶部菜单导航 -->
<script id="tpl-topMenuNav" type="text/html">
    <!-- 菜单区 -->
    <div class="topMenuNav lev1 lev" id="topMenuNavContainer" style="width: {{= d.width}}px">
        <ul class="topNavContainer lev1Ul">
            {{# for(var i = 0, len = d.currentNavGroupArray.length; i < len; i++){ }}
            <li class="lev1Li" style="max-width: {{ d.lev1MaxTextWidth }}px;">
                <div class="lev1Title navTitleName" title="{{= d.currentNavGroupArray[i].name.escapeJavascript() }}" onmouseenter="javascript:topNavShowChildAndFixPostion(this,'{{ d.eachLiHeight }}')" onmouseleave="javascript:topNavHideChild(event,this)"{{# if(d.currentNavGroupArray[i].url){ }} onclick="javascript:showMenu('{{_ctxPath + d.currentNavGroupArray[i].url }}','{{ d.currentNavGroupArray[i].id }}','{{ d.currentNavGroupArray[i].target }}','{{ d.currentNavGroupArray[i].resourceCode }}',this)" style="cursor: pointer;"{{# }else{ }} style="cursor: default;" {{#} }}>
                    <div class="navText">{{= d.currentNavGroupArray[i].name.escapeJavascript() }}</div>
                </div>
                {{# if(d.currentNavGroupArray[i]["items"]){ }}
                <div class="lev2 lev" onmouseenter="javascript:topNavShowThisLev(this)" onmouseleave="javascript:topNavHideThisLev(this)">
                    <div class="navScrollUp" onselectstart="return false" onclick="javascript:navScrollUp(this,'{{ d.eachLiHeight }}')"><i class="vportal vp-arrow-up-serif"></i></div>
                    <ul class="lev2Ul">
                        {{# for(var j = 0, _len = d.currentNavGroupArray[i]["items"].length; j < _len; j++){ }}
                        <li class="lev2Li" style="height: {{ d.eachLiHeight }}px;line-height: {{ d.eachLiHeight }}px" id="lev2_{{ d.currentNavGroupArray[i].items[j].id }}">
                            <div id="{{ d.currentNavGroupArray[i].items[j].resourceCode }}" class="lev2Title navTitleName" title="{{= d.currentNavGroupArray[i]['items'][j].name.escapeJavascript() }}" {{# if (d.currentNavGroupArray[i].items[j].url) { }} onclick="javascript:showMenu('{{_ctxPath + d.currentNavGroupArray[i].items[j].url }}','{{ d.currentNavGroupArray[i].items[j].id }}','{{ d.currentNavGroupArray[i].items[j].target }}','{{ d.currentNavGroupArray[i].items[j].resourceCode }}',this)"{{# } }} onmouseenter="javascript:topNavShowChildAndFixPostion(this,'{{ d.eachLiHeight }}')" onmouseleave="javascript:topNavHideChild(event,this)" data-id="{{ d.currentNavGroupArray[i].items[j].id }}">
                                {{# var iconValue = d.currentNavGroupArray[i].items[j].icon; }}
                                {{# if(iconValue && iconValue.indexOf("/fileUpload.do") > -1){ }}
                                <div class="navIcon"><img src="{{ _ctxPath + iconValue + CsrfGuard.getUrlSurffix() }}" /></div>
                                {{#}else if(iconValue && iconValue.indexOf(_ctxPath) > -1){ }}
                                <div class="navIcon"><img src="{{ iconValue + CsrfGuard.getUrlSurffix() }}" /></div>
                                {{#}else if(iconValue){ }}
                                <div class="navIcon"><i class="vportal vp-{{ iconValue }}"></i></div>
                                {{# } }}
                                <div class="navText">{{= d.currentNavGroupArray[i].items[j].name.escapeJavascript() }}</div>
                                {{# if(d.currentNavGroupArray[i].items[j].items && d.currentNavGroupArray[i].items[j].items.length > 0){ }}<div class="arrow"><i class="vportal vp-arrow-right-serif"></i></div>{{#} }}
                            </div>
                            {{# if(d.currentNavGroupArray[i].items[j].items){ }}
                            <div class="lev3 lev" onmouseenter="javascript:topNavShowThisLev(this)" onmouseleave="javascript:topNavHideThisLev(this)">
                                <div class="navScrollUp" onselectstart="return false" onclick="javascript:navScrollUp(this,'{{ d.eachLiHeight }}')"><i class="vportal vp-arrow-up-serif"></i></div>
                                <ul class="lev3Ul">
                                    {{# for(var k = 0, __len = d.currentNavGroupArray[i]["items"][j]["items"].length; k < __len; k++){ }}
                                    <li class="lev3Li" style="height: {{ d.eachLiHeight }}px;line-height: {{ d.eachLiHeight }}px">
                                        <div class="lev3Title navTitleName" title="{{= d.currentNavGroupArray[i]['items'][j]['items'][k].name.escapeJavascript() }}" {{# if (d.currentNavGroupArray[i].items[j].items[k].url) { }} onclick="javascript:showMenu('{{_ctxPath + d.currentNavGroupArray[i].items[j].items[k].url }}','{{ d.currentNavGroupArray[i].items[j].items[k].id }}','{{ d.currentNavGroupArray[i].items[j].items[k].target }}','{{ d.currentNavGroupArray[i].items[j].items[k].resourceCode }}',this)"{{# } }} onmouseenter="javascript:topNavShowChildAndFixPostion(this,'{{ d.eachLiHeight }}')" onmouseleave="javascript:topNavHideChild(event,this)"><span class="navText">{{= d.currentNavGroupArray[i]["items"][j]["items"][k].name.escapeJavascript() }}</span></div>
                                        {{# if(d.currentNavGroupArray[i].items[j].items[k].items){ }}
                                        <div class="lev4 lev" onmouseenter="javascript:topNavShowThisLev(this)" onmouseleave="javascript:topNavHideThisLev(this)">
                                            <div class="navScrollUp" onselectstart="return false" onclick="javascript:navScrollUp(this,'{{ d.eachLiHeight }}')"><i class="vportal vp-arrow-up-serif"></i></div>
                                            <ul class="lev4Ul">
                                                {{# for(var l = 0, ___len = d.currentNavGroupArray[i]["items"][j]["items"][k]["items"].length; l < ___len; l++){ }}
                                                <li class="lev4Li" style="height: {{ d.eachLiHeight }}px;line-height: {{ d.eachLiHeight }}px">
                                                    <div class="lev4Title navTitleName" title="{{= d.currentNavGroupArray[i]['items'][j]['items'][k]['items'][l].name.escapeJavascript() }}" {{# if (d.currentNavGroupArray[i].items[j].items[k].items[l].url) { }} onclick="javascript:showMenu('{{_ctxPath + d.currentNavGroupArray[i].items[j].items[k].items[l].url }}','{{ d.currentNavGroupArray[i].items[j].items[k].items[l].id }}','{{ d.currentNavGroupArray[i].items[j].items[k].items[l].target }}','{{ d.currentNavGroupArray[i].items[j].items[k].items[l].resourceCode }}',this)"{{# } }} onmouseenter="javascript:topNavShowChildAndFixPostion(this,'{{ d.eachLiHeight }}','{{ d.domId }}')"><span class="navText">{{= d.currentNavGroupArray[i]["items"][j]["items"][k].name.escapeJavascript() }}</span></div>
                                                </li>
                                                {{# } }}
                                            </ul>
                                            <div class="navScrollDown" onselectstart="return false" onclick="javascript:navScrollDown(this,'{{ d.eachLiHeight }}')"><i class="vportal vp-arrow-down-serif"></i></div>
                                        </div>
                                        {{# } }}
                                    </li>
                                    {{# } }}
                                </ul>
                                <div class="navScrollDown" onselectstart="return false" onclick="javascript:navScrollDown(this,'{{ d.eachLiHeight }}')"><i class="vportal vp-arrow-down-serif"></i></div>
                            </div>
                            {{# } }}
                        </li>
                        {{# } }}
                    </ul>
                    <div class="navScrollDown" onselectstart="return false" onclick="javascript:navScrollDown(this,'{{ d.eachLiHeight }}')"><i class="vportal vp-arrow-down-serif"></i></div>
                </div>
                {{#} }}
            </li>
            {{# } }}
        </ul>
        <ul class="pageArea">
            <li id="topNavPrev" class="disabled" onselectstart="return false" title="上一页"><i class="vportal vp-arrow-left-serif"></i></li>
            <li id="topNavNext" class="disabled" onselectstart="return false" title="下一页"><i class="vportal vp-arrow-right-serif"></i></li>
        </ul>
        <div id="activeSubNav" class="activeSubNav" onmouseenter="javascript:showActiveNavAndParent(event,this)" onmouseleave="javascript:hideActiveNavAndParent(event,this)">
            <div class="navScrollUp navScrollBtn" onselectstart="return false" onclick="javascript:navScrollUp(this,'{{ d.eachLiHeight }}')"><i class="vportal vp-arrow-up-serif"></i></div>
            <div id="activeSubNavInner" class="activeSubNavInner"></div>
            <div class="navScrollDown navScrollBtn" onselectstart="return false" onclick="javascript:navScrollDown(this,'{{ d.eachLiHeight }}')"><i class="vportal vp-arrow-down-serif"></i></div>
        </div>
    </div>
</script>

<!--消息盒子(底部弹出)-->
<script id="tpl-messageBottom" type="text/html">
    <div class="messageBlock" id="messageBlock" onclick="javascript:vPortalMainFrameElements.messageBottom.toggleMsgbox();"><span class="msg_remind"></span><i class="vportal vp-remind"></i></div>
    <div class="messageBottom display_none" id="messageBottom">

        <div class="messageBottomTitle">
            <span>{{$.i18n("message.header.more.set")}}（<label id="sysMsgTotalCount1">0</label>）</span>
            <i class="vportal vp-min right" onclick="javascript:vPortalMainFrameElements.messageBottom.toggleMsgbox();"></i>
        </div>

        <div class="msgTab display_none" id="tab_messageBottomTab">
            <div class="tabMoreDiv"><i class="vportal vp-arrow-down-serif"></i><div class="tabMoreDivIn"><div class="tabMoreDivInC" id="tabMore_messageBottomTab"></div></div></div>
        </div>


        <div class="messageUl" id="messageUl">

        </div>

        <div class="msgSetting">
            <i class="vportal vp-setting margin_r_10" onclick="javascript:vPortalMainFrameElements.messageBottom.showMessageSet(_ctxPath +'/message.do?method=showMessageSetting&fromModel=top');"></i>
            <span class="msgSettingMenu" onclick="javascript:vPortalMainFrameElements.messageBottom.ignoreAllSysMsg();">{{$.i18n('portal.message.ignoreall')}}</span>
            <span class="msgSettingMenu" onclick="javascript:vPortalMainFrameElements.messageBottom.showMoreMessage()">{{$.i18n('portal.message.seeall')}}</span>
        </div>

    </div>



    <iframe id="playSoundHelper" class="hidden" frameborder="0" height="0" width="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>
</script>

<!-- 首页设置 -->
<script id="tpl-skinSet" type="text/html">
    <div id="skin_set" class="skin_set_contaner display_none">
        <div class="skin_top_bar">
            <div class="skin_top_bar_right">
                <span class="padding_l_10 margin_r_5 hand padding_r_10" onclick="javascript:vPortalMainFrameElements.skinSet.spaceSet()">{{ $.i18n("menu.personalset.spaceset")}}</span>
                {{# if(!vPortal || !vPortal.navCustomSwitch || vPortal.navCustomSwitch == '1') { }}
                <span class="padding_l_10 margin_r_5 hand padding_r_10" id="navSetId" onclick="javascript:vPortalMainFrameElements.skinSet.configSpaceNav()">{{ $.i18n("vportal.skinSet.nav.label")}}</span>
                {{#}}}
                {{# if(!vPortal || !vPortal.menuCustomSwitch || vPortal.menuCustomSwitch == '1') { }}
                <span class="margin_l_5 margin_r_5 hand padding_l_10 padding_r_10" id="menuSetId" onclick="javascript:vPortalMainFrameElements.skinSet.menusSet()">{{ $.i18n("portal.design.MenuSettings")}}</span>
                {{#}}}
                {{# if( !((vPortal.themeHotspots.topShortcutNav && vPortal.themeHotspots.topShortcutNav.showShortcutNav == "0") || (vPortal.themeHotspots.leftShortcutNav && vPortal.themeHotspots.leftShortcutNav.showShortcutNav == "0")) ){}}
                <span class="margin_l_5 hand padding_l_10 padding_r_10" onclick="javascript:vPortalMainFrameElements.skinSet.quickMenu()">{{ $.i18n("portal.design.QuickSetting")}}</span>
                {{#}}}
                <i onclick="javascript:vPortalMainFrameElements.skinSet.hideSkinPanle();" class="margin_l_20 hand vportal vp-icon vp-close closeSkinSet"></i>
            </div>
            <div class="skin_top_bar_left">
                {{# for(var i=0;i<d.length;i++){
                var choosed = "";
                if(d[i].code=='0'){
                choosed = "choosed";
                }
                }}
                <span id="theme_category_{{d[i].code}}" class="padding_l_5 hand padding_r_5 {{choosed}}" onclick="javascript:vPortalMainFrameElements.skinSet.chooseOperate({{d[i].code}})">{{ $.i18n(d[i].name)}}</span>
                {{# }}}
                <!--<span class="padding_l_5 hand padding_r_5 choosed" onclick="javascript:vPortalMainFrameElements.skinSet.chooseOperate(0)">{{ $.i18n("portal.theme.category.all")}}</span>
                <span class="padding_l_5 hand padding_r_5" onclick="javascript:vPortalMainFrameElements.skinSet.chooseOperate(0)">{{ $.i18n("portal.theme.category.work")}}</span>
                <span class="padding_l_5 hand padding_r_5" onclick="javascript:vPortalMainFrameElements.skinSet.chooseOperate(0)">{{ $.i18n("portal.theme.category.business")}}</span>
                <span class="padding_l_5 hand padding_r_5" onclick="javascript:vPortalMainFrameElements.skinSet.chooseOperate(0)">{{ $.i18n("portal.theme.category.functions")}}</span> -->
                <!-- <span class="padding_l_5 hand padding_r_5 choosed" onclick="javascript:vPortalMainFrameElements.skinSet.chooseOperate(0)">{{ $.i18n("vportal.skinSet.template.label")}}</span> -->
                <!-- <span class="margin_r_5 hand padding_l_5 padding_r_5" onclick="javascript:vPortalMainFrameElements.skinSet.chooseOperate(1)">皮肤</span> -->
            </div>
        </div>
        <div class="skin_content_tabs" id="skin_content"></div>
    </div>
</script>

<!-- 栏目外框架 -->
<script id="tpl-sectionMainFrame" type="text/html">
    {{# if(d.sections.length > 0){ }}
    {{#
    var moreClassStr = '';
    var moreinnerHtmlStr = '';
    var tabsFontsize = '16px';
    if(vPortal.themeHotspots && vPortal.themeHotspots.section && vPortal.themeHotspots.section.sectionMoreButtonType =='text'){
    moreClassStr =  " section-header-more-text";
    moreinnerHtmlStr = vPortal.themeHotspots.section.sectionMoreButtonText_text?vPortal.themeHotspots.section.sectionMoreButtonText_text:$.i18n("common.more.label");
    }

    if(vPortal.themeHotspots && vPortal.themeHotspots.section && vPortal.themeHotspots.section.sectionHeaderTabsFontSize){
    tabsFontsize = vPortal.themeHotspots.section.sectionHeaderTabsFontSize + "px";
    }
    }}
    {{# if(d.style == undefined || d.style == "default" || d.style == "standard" || (d.style == "card1" || d.style == "card2" || d.style == "card3" || d.style == "card4") && (d.sections.length == 1 && ( !d.bigTitles || d.bigTitles.length==1 ) )) {  }}
    <!-- 标准页签(standard)，card1或card2且是单页签时，均使用标准页签的展现方式 -->
    <!-- 标题区样式：默认样式 -->
    {{#  if(d.style != "standard" && d.style != "default" && d.sbt == "1") {  }}
    <!-- 大标题区 -->
    <div class="section-bigTitle" id="section-bigTitle-{{ d.id }}">
        <div class="section-bigTitleInnerArea">
            <!-- 大标题区：图标 -->
            <span class="section-bigTitle-icon"><i class="{{ d.b_i }}"></i></span>
            <!-- 大标题区：标题名称 -->
            <span class="section-bigTitle-text"{{# if(d.b_i == "") {}} style="font-size: {{tabsFontsize}}; left:0;"{{# } }}>{{ d.b_t }}</span>
        </div>
    </div>
    {{# } }}
    {{#  if(d.sst == "1") {  }}
    <!-- 标题区 -->
    <div class="section-header standard {{#  if(d.s_i == '') {  }}noIcon{{# } }}"  id="section-header-{{ d.id }}">
        <!-- 标题区：图标 -->
        <div class="section-header-icon"><i class="vportal vp-section-{{d.s_i}}"></i></div>
        <!-- 标题区：页签 -->
        <div class="section-header-tabs" style="font-size: {{tabsFontsize}};" id="sectionHeaderTabs_{{ d.id }}"></div>
        <!-- AI智能排序 -->
        <div class="section-header-aiSort" id="aiSort-{{ d.id }}"></div>
        <!-- 标题区：按钮图标 -->
        <div class="section-header-button" id="sectionHeaderButton_{{ d.id }}">
            {{# if(isAllowdefined == "true"){ }}
            <div class="btnGroup sectionButton-Setting" id="sectionButtonSetting_{{ d.id }}">
                <span><i class="vportal vp-section-btn-setting"></i></span>
                <div class="btnMoreListArea">
                    <ul class="btnMoreList">
                        <li id="edit_section_{{ d.id }}" onclick="javascript:sectionOperation('{{ d.sections[0].id }}','loadSectionPro')" title="{{$.i18n('portal.button.sectionEdit')}}"><div>{{$.i18n('portal.button.sectionEdit')}}</div></li>
                        <li id="del_section_{{ d.id }}" onclick="javascript:sectionOperation('{{ d.sections[0].id }}','deleteFragment')" title="{{$.i18n('portal.button.sectionDel')}}"><div>{{$.i18n('portal.button.sectionDel')}}</div></li>
                        <li id="add_section_{{ d.id }}" onclick="javascript:sectionOperation('{{ d.sections[0].id }}','addSectionsToFrag')" title="{{$.i18n('portal.button.sectionAdd')}}"><div>{{$.i18n('portal.button.sectionAdd')}}</div></li>
                        {{#  if( (d.sections.length > 1) || (d.bigTitles && d.bigTitles.length>1)) {  }}
                        <div class="dividerLine"></div>
                        <li id="mbt_section_{{ d.id }}" onclick="javascript:sectionOperation('{{ d.sections[0].id }}','modifyBigTitlePro')" title="{{$.i18n('portal.button.sectionCombinationEdit')}}"><div>{{$.i18n('portal.button.sectionCombinationEdit')}}</div></li>
                        {{#  if( (d.style != "standard") && (d.b_t)) {  }}
                        <li id="mbt_del_section_{{ d.id }}" onclick="javascript:sectionOperation('{{ d.sections[0].id }}','deleteBigTitlePro')" title="{{$.i18n('portal.button.sectionCombinationDelete')}}"><div>{{$.i18n('portal.button.sectionCombinationDelete')}}</div></li>
                        <li id="mbt_add_section_{{ d.id }}" onclick="javascript:sectionOperation('{{ d.sections[0].id }}','addBigTitlePro')" title="{{$.i18n('portal.button.sectionCombinationAdd')}}"><div>{{$.i18n('portal.button.sectionCombinationAdd')}}</div></li>
                        {{# } }}
                        {{# } }}
                    </ul>
                </div>
            </div>
            {{# } }}
            <div class="btnGroup sectionButton-allInOne" id="sectionButtonAllInOne{{ d.id }}"></div>
        </div>
        <!-- 标题区：更多 -->
        <div class="section-header-more {{moreClassStr}}" id="sectionHeaderMore{{ d.id }}">{{moreinnerHtmlStr}}</div>
    </div>
    {{# } }}
    {{# }else if(d.style == "card1" || d.style == "card2" || d.style == "card3" || d.style == "card4"){ }}
    <!-- 标题区样式：样式1、样式2 -->
    <!-- 大标题区 -->
    <div class="section-bigTitle" id="section-bigTitle-{{ d.id }}">
        <div class="section-bigTitleInnerArea">
            <!-- 大标题区：图标 -->
            <span class="section-bigTitle-icon"><i class="{{ d.b_i }}"></i></span>
            <!-- 大标题区：标题名称-->
            <!-- 组合栏目 多页签 -->
            <div class="section-header-tabs section-bigTitle-text {{# if(!d.bigTitles ){ }} section-bigTitle-only1{{# } }}" id="sectionBigTitleTabs_{{ d.id }}" {{# if(d.b_i == "") {}} style="font-size: {{tabsFontsize}}; left:0;"{{# } }}>
            {{# if(!d.bigTitles ){ }}
            <!-- 老数据，只有一个组合栏目标题的时候直接渲染 -->
            <ul class="showedTabs">
                <li indexnum="0" class="current" title="{{ d.b_t }}"><div><span>{{ d.b_t!=''?d.b_t:'&nbsp;' }}</span></div></li>
            </ul>
            {{# } }}
        </div>
    </div>
    <!-- AI智能排序 -->
    <div class="section-header-aiSort" id="aiSort-{{ d.id }}"></div>
    <!-- 大标题区：按钮图标 -->
    <div class="section-header-button">
        {{# if(isAllowdefined == "true"){ }}
        <div class="btnGroup sectionButton-Setting" id="sectionButtonSetting_{{ d.id }}">
            <span><i class="vportal vp-section-btn-setting"></i></span>
            <div class="btnMoreListArea">
                <ul class="btnMoreList">
                    <li id="edit_section_{{ d.id }}" onclick="javascript:sectionOperation('{{ d.sections[0].id }}','loadSectionPro')" title="{{$.i18n('portal.button.sectionEdit')}}"><div>{{$.i18n('portal.button.sectionEdit')}}</div></li>
                    <li id="del_section_{{ d.id }}" onclick="javascript:sectionOperation('{{ d.sections[0].id }}','deleteFragment')" title="{{$.i18n('portal.button.sectionDel')}}"><div>{{$.i18n('portal.button.sectionDel')}}</div></li>
                    <li id="add_section_{{ d.id }}" onclick="javascript:sectionOperation('{{ d.sections[0].id }}','addSectionsToFrag')" title="{{$.i18n('portal.button.sectionAdd')}}"><div>{{$.i18n('portal.button.sectionAdd')}}</div></li>
                    {{#  if( (d.sections.length > 1) || (d.bigTitles && d.bigTitles.length>1)) {  }}
                    <div class="dividerLine"></div>
                    <li id="mbt_section_{{ d.id }}" onclick="javascript:sectionOperation('{{ d.sections[0].id }}','modifyBigTitlePro')" title="{{$.i18n('portal.button.sectionCombinationEdit')}}"><div>{{$.i18n('portal.button.sectionCombinationEdit')}}</div></li>
                    {{#  if( (d.style != "standard") && (d.b_t)) {  }}
                    <li id="mbt_del_section_{{ d.id }}" onclick="javascript:sectionOperation('{{ d.sections[0].id }}','deleteBigTitlePro')" title="{{$.i18n('portal.button.sectionCombinationDelete')}}"><div>{{$.i18n('portal.button.sectionCombinationDelete')}}</div></li>
                    <li id="mbt_add_section_{{ d.id }}" onclick="javascript:sectionOperation('{{ d.sections[0].id }}','addBigTitlePro')" title="{{$.i18n('portal.button.sectionCombinationAdd')}}"><div>{{$.i18n('portal.button.sectionCombinationAdd')}}</div></li>
                    {{# } }}
                    {{# } }}
                </ul>
            </div>
        </div>
        {{# } }}
        <div class="btnGroup sectionButton-allInOne" id="sectionButtonAllInOne{{ d.id }}"></div>
    </div>
    <!-- 标题区：更多 -->
    <div class="section-header-more {{moreClassStr}}" id="sectionHeaderMore{{ d.id }}">{{moreinnerHtmlStr}}</div>
    </div>
    {{#  if(d.sst == "1") {  }}
    {{# var _sectionLen = d.sections.length; }}
    {{# var _eachRowWidth = 150 * _sectionLen > d._sectionWidth ? 150 : d._sectionWidth / _sectionLen; }}
    {{# if(d.style == "card1"){ }}
    {{#
    var circlrAreaColor = ["#dbedfb","#e7e9fd","#dde6ff","#ffe9e2","#d8f1ff","#d7ecfd","#ffefd9"];
    var innerCircleColor = ["#49a4ea","#8693f3","#5484ff","#ff916e","#3cbaff","#38a0f5","#ffae43"];
    }}
    <!-- 标题区样式：样式1 -->
    <div class="section-header section-header-{{ d.style }}" id="section-header-{{ d.id }}">
        <ul style="width:{{= _eachRowWidth * _sectionLen }}px;">
            {{# for(var i = 0, len = _sectionLen; i < len; i++){ }}
            {{#
            var _colorIndex = i < 7 ? i : (i - 1) % 7;
            /**背景色**/
            var _currentSectionColor = innerCircleColor[_colorIndex];
            if(d.sections[i].sectionTabBgColor && d.sections[i].sectionTabBgColor!= "null"){
            _currentSectionColor = d.sections[i].sectionTabBgColor;
            }

            /**图标**/
            var _currentSectionIcon = "vp-personality-icon"+_colorIndex;
            if(d.sections[i].sectionTabIcon && d.sections[i].sectionTabIcon!= "null"){
            _currentSectionIcon = d.sections[i].sectionTabIcon;
            }

            /**
            **默认图标  vp-asset-change**
            **自定义了图标   1|vp-asset-change**
            **自定义 上传了图片  0|fileupload**
            **/
            }}
            <li id="sectionName_{{ d.sections[i].id }}"{{# if(i==0){ }} class="current" {{# } }} title="{{ windowAtob(d.sections[i].sl).escapeHTML(true) }}" onclick="javascript:changeTabAndReloadSection('{{ d.id }}','{{ d.sections[i].id }}')" style="width:{{ _eachRowWidth }}px;">
                <div class="leftIcon">
                    <div class="circleArea">
                        <div class="outerCircle" style="background-color: {{= _currentSectionColor }}"></div>
                        <div class="innerCircle" style="background-color: {{ _currentSectionColor }}">
                            {{# if(_currentSectionIcon.indexOf("|") == -1){ }}
                            <i class="vportal {{ _currentSectionIcon }}"></i>
                            {{# }else if(_currentSectionIcon.indexOf('|') != -1 && _currentSectionIcon.split('|')[0] == 1){ }}
                            <i class="vportal {{ _currentSectionIcon.split('|')[1] }}"></i>
                            {{# }else{ }}
                            <img width='20' height='20' src="{{ _currentSectionIcon.split('|')[1] }}">
                            {{# } }}

                        </div>
                    </div>
                </div>
                <div class="rightText">
                    <p class="tabsNumber" id="total_{{ d.sections[i].id }}">{{ getTotalStr(d.sections[i].t) }}</p>
                    <p class="tabsName text_overflow"{{# if(d.sections[i].t==""){ }} style="margin-top: 15px;"{{# } }}  id="titleName_{{ d.sections[i].id }}">{{ windowAtob(d.sections[i].sl).escapeHTML(true) }}</p>
                </div>
            </li>
            {{# } }}
        </ul>
    </div>
    {{# }else if(d.style == "card2"){ }}
    <!-- 标题区样式：样式2 -->
    <div class="section-header section-header-{{ d.style }}" id="section-header-{{ d.id }}">
        <div id="section-header-card2_{{ d.id }}"></div>
    </div>
    {{# }else if(d.style == "card3"){ }}
    <div class="section-header section-header-{{ d.style }}" id="section-header-{{ d.id }}">
        <div class="card3-wrapper" id="section-header-card3_{{ d.id }}">
            {{#
            var _sectionLen = d.sections.length;
            var __sections_tabSelectedColor = "#297ffb";
            var __sections_tabBgColor = "#f3f3f3";
            __sections_tabSelectedColor = d.s_tsc?d.s_tsc:__sections_tabSelectedColor;
            __sections_tabBgColor = d.s_tbc?d.s_tbc:__sections_tabBgColor;
            if(d.bigTitles && d.bigTitles[0]){
            __sections_tabSelectedColor = d.bigTitles[0].s_tsc?d.bigTitles[0].s_tsc:__sections_tabSelectedColor;
            __sections_tabBgColor = d.bigTitles[0].s_tbc?d.bigTitles[0].s_tbc:__sections_tabBgColor;
            }
            }}
            <ul _style="card3" _tabbgcolor="{{__sections_tabBgColor}}" _tabselectedcolor="{{__sections_tabSelectedColor}}">
                {{# for(var i = 0, len = _sectionLen; i < len; i++){ }}
                {{#
                var colorStr = __sections_tabBgColor;
                var borderTopColor = "transparent";
                if(i==0){
                colorStr = borderTopColor = __sections_tabSelectedColor;
                }
                }}
                <li id="sectionName_{{ d.sections[i].id }}" class="{{# if(i==0){ }}current{{# } }}{{# if(d.sections[i].t !== ''){ }} hasTotal{{# } }}" title="{{ windowAtob(d.sections[i].sl).escapeHTML(true) }}" onclick="javascript:changeTabAndReloadSection('{{ d.id }}','{{ d.sections[i].id }}')" style="{{# if(i === len-1){  }}margin-right: 0;{{#} }} background-color: {{colorStr}}">
                    <!-- <div class="tabsArrow" style="border-top-color: {{borderTopColor}}"></div> -->
                    <div class="tabsNumber"><span id="total_{{ d.sections[i].id }}">{{ getTotalStr(d.sections[i].t) }}</span></div>
                    <div class="tabsName text_overflow">{{ windowAtob(d.sections[i].sl).escapeHTML(true) }}</div>
                </li>
                {{# } }}
            </ul>
        </div>
    </div>
    {{# }else if(d.style == "card4"){ }}
    <div class="section-header section-header-{{ d.style }}" id="section-header-{{ d.id }}">
        {{#
        var _sectionLen = d.sections.length;
        var __sections_tabSelectedColor = "#297ffb";
        var __sections_tabBgColor = "#f3f3f3";
        __sections_tabSelectedColor = d.s_tsc?d.s_tsc:__sections_tabSelectedColor;
        __sections_tabBgColor = d.s_tbc?d.s_tbc:__sections_tabBgColor;
        if(d.bigTitles && d.bigTitles[0]){
        __sections_tabSelectedColor = d.bigTitles[0].s_tsc?d.bigTitles[0].s_tsc:__sections_tabSelectedColor;
        __sections_tabBgColor = d.bigTitles[0].s_tbc?d.bigTitles[0].s_tbc:__sections_tabBgColor;
        }
        }}
        <div class="card4-wrapper" id="section-header-card4_{{ d.id }}" style="background-color: {{__sections_tabBgColor}}">
            <div class="card4-left">
                <ul _style="card4" _tabbgcolor="{{__sections_tabBgColor}}" _tabselectedcolor="{{__sections_tabSelectedColor}}">
                    {{# for(var i = 0, len = _sectionLen; i < len; i++){ }}
                    {{#
                    var colorStr = "";
                    if(i==0){
                    colorStr = __sections_tabSelectedColor;
                    }
                    }}
                    <li id="sectionName_{{ d.sections[i].id }}" class="{{# if(i==0){ }}current{{# } }}" title="{{ windowAtob(d.sections[i].sl).escapeHTML(true) }}" onclick="javascript:changeTabAndReloadSection('{{ d.id }}','{{ d.sections[i].id }}')" style="{{# if(i === len-1){  }}margin-right: 0;{{#} }} background-color: {{colorStr}}">
                        <span class="tabsName">{{ windowAtob(d.sections[i].sl).escapeHTML(true) }}</span>
                        {{# if(d.sections[i].t !== ''){ }}
                        <span class="tabsNumber">(<span id="total_{{ d.sections[i].id }}">{{ getTotalStr(d.sections[i].t) }}</span>)</span>
                        {{# } }}
                    </li>
                    {{# } }}
                </ul>
            </div>
            <div class="card4-right">
                <div class="bgc1" style="background-image: linear-gradient(to right,transparent,{{__sections_tabBgColor}});"></div>
                <div class="bgc2" style="background-color: {{__sections_tabBgColor}}"></div>
                <div class="prev disabled" id="sectionTitlePrev-{{ d.id }}" onclick="javascript:scrollTabs4Card4('left','{{ d.id }}')"><i class="vportal vp-back"></i></div>
                <div class="next" id="sectionTitleNext-{{ d.id }}" onclick="javascript:scrollTabs4Card4('right','{{ d.id }}')"><i class="vportal vp-forward"></i></div>
            </div>
        </div>
    </div>
    {{# } }}
    {{# } }}
    {{# } }}
    <!-- 内容区 -->
    {{# if(d.sst == '0' && (d.sections[0].rf =='multiPictureScrollingTemplate' || d.sections[0].rf == 'pictureRotationBottomTemplete' || d.sections[0].rf == 'pictureRotationLeftTemplete' || d.sections[0].rf == 'morePictureTemplete' || d.sections[0].rf == 'multiPictureTemplete' || d.sections[0].rf == 'pictureCardTemplete' || d.sections[0].rf == 'categoryPictureTitleAndBriefTemplete') || d.sections[0].rf == 'pictureTemplete' || d.sections[0].rf == 'bannerTemplete' || d.sections[0].rf == 'weatherTemplete' || d.sections[0].rf == 'clockTemplete' || d.sections[0].rf == 'showPictureCardTemplete' || d.sections[0].sbd =='loginSection'){ }}
    {{# var needPadding = false; }}
    {{# }else{ }}
    {{# var needPadding = true; }}
    {{#} }}
    <div  class="section-body{{# if(d.sbt == '1' || (d.sst == '1' && d.sections[0].sbd != 'loginSection') || needPadding){ }} padding10_15{{# } }}" id="panelBody_{{ d.id }}" {{# if(d.style == "card2"){ }} style="padding-top:0;"{{# } }}  >
    <span class="contentLoading">{{$.i18n('section.loading.label')}}
                <span class="ellipsis-anim"></span>
            </span>
    </div>
    <!-- 内容区的编辑功能 -->
    <div class="section-editArea" id="panelEditArea_{{ d.id }}">{{$.i18n('section.relatedproperties.label')}}</div>
    <!-- 栏目底部区 -->
    <!-- <div class="section-footer"></div> -->
    {{# } }}
</script>

