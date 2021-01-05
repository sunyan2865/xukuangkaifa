var pageX = {};
pageX.openWin = null;
var grid;

$(document).ready(function () {
    new MxtLayout({
        'id': 'layout',
        'northArea': {
            'id': 'north',
            'height': 67,
            'sprit': false,
            'border': false
        },
        'centerArea': {
            'id': 'center',
            'sprit':false,
            'border': false,
            'minHeight': 20
        }
    });


    var formModel = new Array();
    formModel.push({
        display: 'id',
        name: 'id',
        width: 'smallest',
        type: 'checkbox'
    });
    formModel.push({
        display: '姓名',
        name: 'xm',
        sortable : true,
        width: 'medium'
    });
    formModel.push({
        display:'所在部门',
        name: 'szbm',
        sortable : true,
        width: 'big'
    });
    formModel.push({
        display:'号码',
        name: 'ch',
        sortable : true,
        width: 'big'
    });
    formModel.push({
        display:'短号',
        name: 'dh',
        sortable : true,
        width: 'big'
    });
    formModel.push({
        display:'电子邮箱',
        name: 'email',
        sortable : true,
        width: 'big'
    });



    //表格加载
    grid = $('#listStudent').ajaxgrid({
        colModel: formModel,
        /*  click: clickRow,*/
        render : rend,
        height: 200,
        showTableToggleBtn: false,
        parentId: 'center',
        gridType:'autoGrid',
        vChange: true,
        resizable:false,
        vChangeParam: {
            overflow: "hidden",
            autoResize:false //表格下方是否自动显示
        },
        isHaveIframe:true,
        slideToggleBtn:false,
        managerName : "xntlManager",
        managerMethod : "toXntx"
        //usepager : false
    });


});


function rend(txt, data, r, c) {
    //document.getElementById("spanId").innerText="";
    if(null==txt || txt=="null"){
        txt="";
    }/*else{
        txt="<span  style='background-color:#edeadf'>"+txt+"</span>";
    }*/
    return txt;
}


