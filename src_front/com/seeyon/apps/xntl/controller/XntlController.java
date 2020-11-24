package com.seeyon.apps.xntl.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.seeyon.apps.xntl.manager.XntlManager;
import com.seeyon.ctp.common.AppContext;
import com.seeyon.ctp.common.authenticate.domain.User;
import com.seeyon.ctp.common.controller.BaseController;
import com.seeyon.ctp.common.log.CtpLogFactory;
import com.seeyon.ctp.util.FlipInfo;
import com.seeyon.ctp.util.JDBCAgent;
import org.apache.commons.logging.Log;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

public class XntlController extends BaseController {

    private static final Log LOG = CtpLogFactory.getLog(XntlController.class);

    private XntlManager gwJkManager;


    public XntlManager getGwJkManager() {
        return gwJkManager;
    }

    public void setGwJkManager(XntlManager gwJkManager) {
        this.gwJkManager = gwJkManager;
    }


    /**
     * 跳转到校内通联查询界面
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public ModelAndView toXntx(HttpServletRequest request, HttpServletResponse response)throws Exception{
        response.setContentType("text/html;charset=UTF-8");
        ModelAndView view = new ModelAndView("xntl/xntl_list");
        Map<String,String> query = new HashMap<String,String>();
        FlipInfo fi = new FlipInfo();
        if(gwJkManager == null) {
            gwJkManager = (XntlManager) AppContext.getBean("xntlManager");
        }
        FlipInfo swlist = gwJkManager.toXntx(fi,query);
        request.setAttribute("fflistStudent",swlist);
        return view;
    }

}