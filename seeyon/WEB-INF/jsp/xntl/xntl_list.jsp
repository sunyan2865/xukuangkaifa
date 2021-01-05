<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/common.jsp" %>
<!DOCTYPE html>
<html class="h100b">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>校内通联</title>
    <script type="text/javascript" charset="UTF-8" src="${path}/apps_res/xntl/xntl_list.js${ctp:resSuffix()}"></script>
    <style type="text/css">
        .buttonStyle {
            height: 30px;
            line-height: 1;
            white-space: nowrap;
            cursor: pointer;
            border-radius: 100px;
            padding: 8px 16px;
            font-size: 14px;
            letter-spacing: 0;
            max-width: 146px;
            border: 0;
            outline: none;
        }
        .buttonSx{
            background: #1f85ec;
            color: #FFFFFF;
            margin-left:10px;
        }

        .buttonReset{
            background: #FFFFFF;
            color: #666;
            margin-left: 7px;
            padding: 7px 15px;
            border: 1px solid #d4d4d4;
        }


    </style>
</head>
<body class="h100b" onunload="">
<div id='layout' >
    <div  class="layout_north f0f0f0" id="north">
        <div style="padding-left:15px;margin:20px;text-align:center">
            <input id="searchId" style="height:36px;width:300px;font-size:13px" data-v-1632dfc7="" type="text" placeholder="搜索关键字" class="input cap4-condition-flex-a"/>
            <button id="sxBtn" class="buttonStyle buttonSx">搜索</button>
            <button id="reset" class="buttonStyle buttonReset">重置</button>
          <%--  <span id="spanId"  style="padding-left:30px;color:green">暂无数据</span>--%>
        </div>
    </div>
    <div style="background-color: #edeadf" class="layout_center over_hidden" id="center">
        <table  class="flexme3" id="listStudent"></table>
    </div>
</div>

<script type="text/javascript">
    $("#sxBtn").click(function(){
        var val = $("#searchId").val();
        if(val !== null){
            $("#listStudent").ajaxgridLoad(getSearchValueObj());
        }
    });


    $("#reset").click(function(){
       /* document.getElementById("spanId").innerText="暂无数据";*/
        $("#searchId").val("");
        $("#listStudent").ajaxgridLoad(getSearchValueObj());
    });


    function getSearchValueObj(){
        var o = new Object();
        o.xm = $('#searchId').val().trimLeft();
        return o;
    }

</script>

</body>
</html>
