package com.seeyon.apps.gwjk.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.seeyon.apps.gwjk.manager.GwJkManager;
import com.seeyon.apps.gwxg.po.OpinionEntity;
import com.seeyon.ctp.common.AppContext;
import com.seeyon.ctp.common.authenticate.domain.User;
import com.seeyon.ctp.common.controller.BaseController;
import com.seeyon.ctp.common.log.CtpLogFactory;
import com.seeyon.ctp.util.FlipInfo;
import com.seeyon.ctp.util.JDBCAgent;
import org.apache.commons.logging.Log;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

public class GwjkController  extends BaseController {

    private static final Log LOG = CtpLogFactory.getLog(GwjkController.class);

    private GwJkManager gwJkManager;


    public GwJkManager getGwJkManager() {
        return gwJkManager;
    }

    public void setGwJkManager(GwJkManager gwJkManager) {
        this.gwJkManager = gwJkManager;
    }


    /**
     * 跳转到收文监控查询界面
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public ModelAndView toGwjk(HttpServletRequest request, HttpServletResponse response)throws Exception{
        response.setContentType("text/html;charset=UTF-8");
        ModelAndView view = new ModelAndView("gwjk/gwjk_list");
        Map<String,String> query = new HashMap<String,String>();
        FlipInfo fi = new FlipInfo();
        if(gwJkManager == null) {
            gwJkManager = (GwJkManager) AppContext.getBean("gwJkManager");
        }
        FlipInfo swlist = gwJkManager.toGwjk(fi,query);
        request.setAttribute("fflistStudent",swlist);

        return view;
    }


    /**
     * 查看收文意见详情界面
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public ModelAndView toOpinionView(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView modelAndView = new ModelAndView("gwjk/scan_opinion");
        String edoc_id = request.getParameter("edoc_id");
        String affair_id=request.getParameter("affair_id");
        String sql="select content from EDOC_OPINION  where  edoc_id='"+edoc_id+"' and  affair_id='"+affair_id+"'";
        Map<String, Object> opiniondata = null;
        JDBCAgent jdbcAgent = new JDBCAgent(true, false);
        try {
            jdbcAgent.execute(sql);
            opiniondata=jdbcAgent.resultSetToMap();
            modelAndView.addObject("opinion", opiniondata);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return modelAndView;
    }


    /**
     * 跳转到收文详情界面
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public ModelAndView toSwDetailView(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView modelAndView = new ModelAndView("gwjk/swxx_detail");
        String formid = request.getParameter("id");
        String summaryid = request.getParameter("summaryid");
        String sql=" select e.showvalue lwdw,concat(e1.showvalue,e2.showvalue) jgdz,e3.showvalue clxz,e4.showvalue hj,u.name, t.*  from formmain_0081 t " +
                " left join (select id,showvalue from ctp_enum_item where ref_enumid='-82570973940398271' and state='1') e on e.id=t.field0001 " +
                " left join (select id,showvalue from ctp_enum_item where ref_enumid='5765437337868452209' and parent_id='0' and state='1') e1 on e1.id=t.field0021 " +
                " left join (select id,showvalue from ctp_enum_item where ref_enumid='5765437337868452209' and parent_id!='0' and state='1') e2 on e2.id=t.field0022 " +
                " left join (select id,showvalue from ctp_enum_item where ref_enumid='6534952330511468065' and state='1') e3 on e3.id=t.field0011 " +
                " left join (select id,showvalue from ctp_enum_item where ref_enumid='404' and state='1') e4 on e4.id=t.field0012 " +
                " left join org_member u on u.id=t.field0015  where  t.id='"+formid+"'";
        Map<String, Object> swxxdata = null;
        JDBCAgent jdbcAgent = new JDBCAgent(true, false);
        try {
            jdbcAgent.execute(sql);
            swxxdata=jdbcAgent.resultSetToMap();

            swxxdata.put("zrdwmc",getDepartmentName(swxxdata.get("field0018"),jdbcAgent));
            modelAndView.addObject("entity", swxxdata);




            //拟办、批示、办理意见
            List<Map<String, Object>> yjlist = null;
            String ideaSql = " select id,content,create_time,(select name from ORG_MEMBER where id=CREATE_USER_ID) username,policy , " +
                    " ( select group_concat(FILENAME) from CTP_ATTACHMENT where sub_REFERENCE=o.id) filename from  EDOC_OPINION o where   edoc_id ='" + summaryid + "'  order by create_time asc";
            jdbcAgent.execute(ideaSql);
            yjlist=jdbcAgent.resultSetToList();
             /* field0007：党政办拟办意见
            field0008：校领导批示意见
            field0010：部门承办意见*/
            List<OpinionEntity> dzbList = new ArrayList<>();
            List<OpinionEntity> xldpsList = new ArrayList<>();
            List<OpinionEntity> bmList = new ArrayList<>();
            for(int p=0;p<yjlist.size();p++){
                Map<String, Object> m = yjlist.get(p);
                OpinionEntity opinion = new OpinionEntity();
                opinion.setId(String.valueOf(m.get("id")));
                opinion.setContent((String)m.get("content"));
                opinion.setCreateTime(m.get("create_time").toString().substring(0,10));
                opinion.setUsername((String)m.get("username"));
                opinion.setPolicy((String)m.get("policy"));
                opinion.setFilename((String)m.get("filename"));
                String policy = (String)m.get("policy");
                if ("field0007".equals(policy)) {
                    dzbList.add(opinion);
                }
                if ("field0008".equals(policy)) {
                    xldpsList.add(opinion);
                }
                if ("field0010".equals(policy)) {
                    bmList.add(opinion);
                }
            }
            modelAndView.addObject("dzbList", dzbList);
            modelAndView.addObject("xldpsList", xldpsList);
            modelAndView.addObject("bmList", bmList);


            //附件 field0019
            String fjmainId=(String)swxxdata.get("field0019");
            String fjsql="select a.*,DATE_FORMAT(createdate,'%Y-%m-%d') as date,RIGHT(filename, INSTR(REVERSE(filename),'.')) filextension,round(a.ATTACHMENT_SIZE/1024,0) filesize from ctp_attachment  a where a.SUB_REFERENCE  ='"+fjmainId+"'";
            List<Map<String, Object>> fjList=null;
            jdbcAgent.execute(fjsql);
            fjList=jdbcAgent.resultSetToList();
            com.alibaba.fastjson.JSONArray fjsonArray = com.alibaba.fastjson.JSONArray.parseArray(JSON.toJSONString(fjList));
            modelAndView.addObject("fjsonArray", fjsonArray);
            modelAndView.addObject("fjlist", fjList);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            jdbcAgent.close();
        }
        return modelAndView;
    }



    /**
     * 更新自定义表中的个人事项状态：
     * 20 已办未读 21已办已读
     * @param request
     * @param response
     * @return
     */
    public ModelAndView toUpdateAffairState(HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> jsonMap = new HashMap();
        JDBCAgent jdbcAgent = new JDBCAgent(true, false);
        try {
            String summaryid = request.getParameter("summaryid");
            String affairid = request.getParameter("affairid");

            String sql="update ctp_affair_define_state set state='21' where summaryid='"+summaryid+"' and affairid='"+affairid+"'";
            jdbcAgent.execute(sql);
            map.put("code", 0);
        }catch(Exception e){
            map.put("code", -1);
        } finally {
            jdbcAgent.close();
        }
        com.alibaba.fastjson.JSONObject json = new JSONObject(map);
        render(response, json.toJSONString());
        return null;
    }

    /**
     * 给前台渲染json数据
     *
     * @param response
     * @param text
     */
    private void render(HttpServletResponse response, String text) {
        response.setContentType("application/json;charset=UTF-8");
        try {
            response.setContentLength(text.getBytes("UTF-8").length);
            response.getWriter().write(text);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private  String getDepartmentName(Object obj,JDBCAgent jdbcAgent){
        String result="";
        if(null==obj || obj.equals("")){
            return result;
        }else{
            String[] arr=obj.toString().split(",");
            String idstr="";

            for(int m=0;m<arr.length;m++){
                idstr+="'"+arr[m].replace("Department|","")+"',";
            }
            String zbsql = "select group_concat(name) zbname from org_unit  where id  in(" + idstr.substring(0,idstr.length()-1) + ")";
            try {
                jdbcAgent.execute(zbsql);
                result=(String)jdbcAgent.resultSetToMap().get("zbname");
            }catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }


    /**
     * 跳转到收文反馈信息界面
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public ModelAndView toSwfkxx(HttpServletRequest request, HttpServletResponse response)throws Exception{
        response.setContentType("text/html;charset=UTF-8");
        ModelAndView view = new ModelAndView("gwjk/sw_fkxx_list");
        Map<String,String> query = new HashMap<String,String>();
        FlipInfo fi = new FlipInfo();
        if(gwJkManager == null) {
            gwJkManager = (GwJkManager) AppContext.getBean("gwJkManager");
        }
        FlipInfo swlist = gwJkManager.toSwfkxx(fi,query);
        request.setAttribute("fflistStudent",swlist);

        return view;
    }




    /**
     * 收文反馈信息：点击则新变成已读
     * @param request
     * @param response
     * @return
     */
    public ModelAndView toUpdateOpinionState(HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> map = new HashMap<>();
        JDBCAgent jdbcAgent = new JDBCAgent(true, false);
        try {
            String opinionid = request.getParameter("opinionid");

            String sql="update edoc_opinion_define_state set state='1' where opinionid='"+opinionid+"'";
            jdbcAgent.execute(sql);
            map.put("code", 0);
        }catch(Exception e){
            map.put("code", -1);
        }
        com.alibaba.fastjson.JSONObject json = new JSONObject(map);
        render(response, json.toJSONString());
        return null;
    }



    /**
     * 跳转到收文-协同办公监控查询界面
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public ModelAndView toXtbgJkList(HttpServletRequest request, HttpServletResponse response)throws Exception{
        response.setContentType("text/html;charset=UTF-8");
        ModelAndView view = new ModelAndView("gwjk/xtbg/xtbg_jk_list");
        Map<String,String> query = new HashMap<String,String>();
        FlipInfo fi = new FlipInfo();
        if(gwJkManager == null) {
            gwJkManager = (GwJkManager) AppContext.getBean("gwJkManager");
        }
        FlipInfo swlist = gwJkManager.toXtbgJkList(fi,query);
        request.setAttribute("fflistStudent",swlist);

        return view;
    }


    /**
     * 跳转到收文-校内请示监控查询界面
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public ModelAndView toXnqsJkList(HttpServletRequest request, HttpServletResponse response)throws Exception{
        response.setContentType("text/html;charset=UTF-8");
        ModelAndView view = new ModelAndView("gwjk/xnqs/xnqs_jk_list");
        Map<String,String> query = new HashMap<String,String>();
        FlipInfo fi = new FlipInfo();
        if(gwJkManager == null) {
            gwJkManager = (GwJkManager) AppContext.getBean("gwJkManager");
        }
        FlipInfo swlist = gwJkManager.toXnqsJkList(fi,query);
        request.setAttribute("fflistStudent",swlist);

        return view;
    }


    /**
     * 跳转到待办界面
     * @param request
     * @param response
     * @return
     */
    public ModelAndView doGwdb(HttpServletRequest request, HttpServletResponse response) throws Exception {
        JDBCAgent jdbcAgent = new JDBCAgent(true, false);
        User user = AppContext.getCurrentUser();
        Map<String, Object> swdata = null;
        try {
            String summaryid = request.getParameter("summaryid");
            String sql = "select a.id affairid,r.id summaryid from edoc_summary r " +
                    "left join ctp_affair a on a.object_id=r.id and a.member_id='"+user.getId()+"' and a.state='3'" +
                    "where r.id='"+summaryid+"'  limit 1 ";
            jdbcAgent.execute(sql);
            swdata=jdbcAgent.resultSetToMap();

            Map<String, Object> revoler = new HashMap<>();
            for (Map.Entry<String, Object> entry : swdata.entrySet()) {
                revoler.put(entry.getKey(), String.valueOf(entry.getValue()) + "");
            }

            Map<String, Object> map = new HashMap<>();
            map.put("code", 0);
            map.put("data", revoler);
            com.alibaba.fastjson.JSONObject json = new JSONObject(map);
            render(response, json.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            jdbcAgent.close();
        }
        return null;
    }

}