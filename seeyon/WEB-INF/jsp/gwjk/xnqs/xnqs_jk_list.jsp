<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/common.jsp" %>
<!DOCTYPE html>
<html class="h100b">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>校内请示监控</title>
    <script type="text/javascript" charset="UTF-8" src="${path}/apps_res/gwjk/xnqs/xnqs_jk_list.js${ctp:resSuffix()}"></script>
</head>
<body class="h100b" onunload="">
<div id='layout'>
    <div class="layout_north f0f0f0" id="north">
        <table width="100%" border="0" cellpadding="0">
            <tr>
                <td><div id="toolbars"></div></td>
                <td style="padding-bottom:5px" width="60" align="center" valign="center">
                </td>
            </tr>
        </table>
    </div>
    <div class="layout_center over_hidden" id="center">
        <table  class="flexme3" id="listStudent"></table>
    </div>

</div>

</body>
</html>
