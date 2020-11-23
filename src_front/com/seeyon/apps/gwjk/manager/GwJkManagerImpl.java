package com.seeyon.apps.gwjk.manager;

import com.seeyon.ctp.common.exceptions.BusinessException;
import com.seeyon.ctp.util.FlipInfo;
import com.seeyon.ctp.util.JDBCAgent;
import com.seeyon.ctp.util.annotation.AjaxAccess;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GwJkManagerImpl implements  GwJkManager {

    @Override
    @AjaxAccess
    @SuppressWarnings("unchecked")
    public FlipInfo toGwjk(FlipInfo flipInfo, Map<String,String> query) throws SQLException, BusinessException {

        StringBuffer sql=new StringBuffer(" select t.*,group_concat(CONCAT(s.name,';',s.memberid,';',s.state,';',s.affairid)) definestate from ( " +
                " select t.id summaryid,f.id formid, f.field0006 wjbt,f.field0016 blqx ,f.field0014 swrq,GROUP_CONCAT(CONCAT(u.name,';',u.id,';',r.state,';',r.id)) name ,f.start_date from formmain_0081 f " +
                " left join  (SELECT * FROM edoc_summary t WHERE t.EDOC_TYPE = '1') t on  t.FORM_RECORDId=f.id " +
                " left join ctp_affair r on r.OBJECT_ID=t.id and r.state in ('3','4') " +
                " left join ORG_MEMBER u on u.id=r.MEMBER_ID " +
                " group by t.id,f.id,f.field0006,f.field0016,f.field0014, f.start_date " +
                " )t  " +
                " left join ctp_affair_define_state s on s.summaryid=t.summaryid " +
                " where 1=1  ");

        if(null != query.get("wjbt")) {
            sql.append(" and wjbt like  '%"+query.get("wjbt") +"%'");
        }

        if(null != query.get("startime")) {
            sql.append(" and swrq >= '"+query.get("startime")+"'");
        }

        if(null != query.get("endtime")) {
            sql.append(" and swrq <= '"+query.get("endtime")+"'");
        }
        sql.append(" group by summaryid,formid,wjbt,blqx,swrq,name,start_date order by start_date desc");
        List<Map<String, Object>> swlist = null;
        List<Map<String, Object>> revoler = new ArrayList<>();
        JDBCAgent jdbcAgent = new JDBCAgent(true, false);
        try {
            jdbcAgent.execute(sql.toString());
            swlist = jdbcAgent.resultSetToList();

            for (int i = 0; i < swlist.size(); i++) {
                Map<String, Object> m = new HashMap<>();
                for (Map.Entry<String, Object> entry : swlist.get(i).entrySet()) {
                    m.put(entry.getKey(), String.valueOf(entry.getValue()) + "");
                }
                revoler.add(m);
            }

        } catch (BusinessException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            jdbcAgent.close();
        }

        flipInfo.setTotal(swlist.size());
        flipInfo.setData(revoler);
        return flipInfo;
    }



    @Override
    @AjaxAccess
    @SuppressWarnings("unchecked")
    public FlipInfo toSwfkxx(FlipInfo flipInfo, Map<String,String> query) throws SQLException, BusinessException {

        StringBuffer sql=new StringBuffer(" select * from (" +
                "  select o.id opinionid,t.id summaryid,f.id formid,f.field0006 wjbt,o.create_time fksj,o.CREATE_USER_ID,r.name,o.content,s.state from formmain_0081 f" +
                "  left join (SELECT * FROM edoc_summary t WHERE t.EDOC_TYPE = '1') t on  t.FORM_RECORDId=f.id " +
                "   join edoc_opinion o on o.edoc_id=t.id" +
                "  left join org_member r on r.id=o.create_user_id" +
                "  left join edoc_opinion_define_state s on s.opinionid=o.id"+
                "  ) t where 1=1  ");

        if(null != query.get("wjbt")) {
            sql.append(" and wjbt like  '%"+query.get("wjbt") +"%'");
        }
        if(null != query.get("name")) {
            sql.append(" and name like  '%"+query.get("name") +"%'");
        }

        sql.append(" order by fksj  desc  ");
        List<Map<String, Object>> swfkxxlist = null;
        List<Map<String, Object>> revoler = new ArrayList<>();
        JDBCAgent jdbcAgent = new JDBCAgent(true, false);
        try {
            jdbcAgent.execute(sql.toString());
            swfkxxlist = jdbcAgent.resultSetToList();

            for (int i = 0; i < swfkxxlist.size(); i++) {
                Map<String, Object> m = new HashMap<>();
                for (Map.Entry<String, Object> entry : swfkxxlist.get(i).entrySet()) {
                    m.put(entry.getKey(), String.valueOf(entry.getValue()) + "");
                }
                revoler.add(m);
            }

        } catch (BusinessException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            jdbcAgent.close();
        }

        flipInfo.setTotal(swfkxxlist.size());
        flipInfo.setData(revoler);
        return flipInfo;
    }




    @Override
    @AjaxAccess
    @SuppressWarnings("unchecked")
    public FlipInfo toXtbgJkList(FlipInfo flipInfo, Map<String,String> query) throws SQLException, BusinessException {

        StringBuffer sql=new StringBuffer(" select t.*,group_concat(CONCAT(s.name,';',s.memberid,';',s.state,';',s.affairid)) definestate from ( " +
                " select t.id summaryid,f.id formid, f.field0001 wjbt,f.field0011 bqrq ,GROUP_CONCAT(CONCAT(u.name,';',u.id,';',r.state,';',r.id)) name ,f.start_date from formmain_0188 f " +
                " left join  (SELECT * FROM edoc_summary t WHERE t.EDOC_TYPE = '1') t on  t.FORM_RECORDId=f.id " +
                " left join ctp_affair r on r.OBJECT_ID=t.id and r.state in ('3','4') " +
                " left join ORG_MEMBER u on u.id=r.MEMBER_ID " +
                " group by t.id,f.id,f.field0001,f.field0011, f.start_date " +
                " )t  " +
                " left join ctp_affair_define_state s on s.summaryid=t.summaryid " +
                " where 1=1  ");

        if(null != query.get("wjbt")) {
            sql.append(" and wjbt like  '%"+query.get("wjbt") +"%'");
        }

        if(null != query.get("startime")) {
            sql.append(" and bqrq >= '"+query.get("startime")+"'");
        }

        if(null != query.get("endtime")) {
            sql.append(" and bqrq <= '"+query.get("endtime")+"'");
        }
        sql.append(" group by summaryid,formid,wjbt,bqrq,name,start_date order by start_date desc");

        List<Map<String, Object>> swlist = null;
        List<Map<String, Object>> revoler = new ArrayList<>();
        JDBCAgent jdbcAgent = new JDBCAgent(true, false);
        try {
            jdbcAgent.execute(sql.toString());
            swlist = jdbcAgent.resultSetToList();

            for (int i = 0; i < swlist.size(); i++) {
                Map<String, Object> m = new HashMap<>();
                for (Map.Entry<String, Object> entry : swlist.get(i).entrySet()) {
                    m.put(entry.getKey(), String.valueOf(entry.getValue()) + "");
                }
                revoler.add(m);
            }

        } catch (BusinessException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            jdbcAgent.close();
        }

        flipInfo.setTotal(swlist.size());
        flipInfo.setData(revoler);
        return flipInfo;
    }




    @Override
    @AjaxAccess
    @SuppressWarnings("unchecked")
    public FlipInfo toXnqsJkList(FlipInfo flipInfo, Map<String,String> query) throws SQLException, BusinessException {

        StringBuffer sql=new StringBuffer(" select t.*,group_concat(CONCAT(s.name,';',s.memberid,';',s.state,';',s.affairid)) definestate from ( " +
                " select t.id summaryid,f.id formid, f.field0003 wjbt,DATE_FORMAT(f.start_date ,'%Y-%m-%d') cjrq,GROUP_CONCAT(CONCAT(u.name,';',u.id,';',r.state,';',r.id)) name ,f.start_date from formmain_0195 f " +
                " left join  (SELECT * FROM edoc_summary t WHERE t.EDOC_TYPE = '0') t on  t.FORM_RECORDId=f.id " +
                " left join ctp_affair r on r.OBJECT_ID=t.id and r.state in ('3','4') " +
                " left join ORG_MEMBER u on u.id=r.MEMBER_ID " +
                " group by t.id,f.id,f.field0003,DATE_FORMAT(f.start_date ,'%Y-%m-%d'), f.start_date " +
                " )t  " +
                " left join ctp_affair_define_state s on s.summaryid=t.summaryid " +
                " where 1=1  ");

        if(null != query.get("wjbt")) {
            sql.append(" and wjbt like  '%"+query.get("wjbt") +"%'");
        }

        if(null != query.get("startime")) {
            sql.append(" and cjrq >= '"+query.get("startime")+"'");
        }

        if(null != query.get("endtime")) {
            sql.append(" and cjrq <= '"+query.get("endtime")+"'");
        }
        sql.append(" group by summaryid,formid,wjbt,cjrq,name,start_date order by start_date desc");
        List<Map<String, Object>> swlist = null;
        List<Map<String, Object>> revoler = new ArrayList<>();
        JDBCAgent jdbcAgent = new JDBCAgent(true, false);
        try {
            jdbcAgent.execute(sql.toString());
            swlist = jdbcAgent.resultSetToList();

            for (int i = 0; i < swlist.size(); i++) {
                Map<String, Object> m = new HashMap<>();
                for (Map.Entry<String, Object> entry : swlist.get(i).entrySet()) {
                    m.put(entry.getKey(), String.valueOf(entry.getValue()) + "");
                }
                revoler.add(m);
            }

        } catch (BusinessException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            jdbcAgent.close();
        }

        flipInfo.setTotal(swlist.size());
        flipInfo.setData(revoler);
        return flipInfo;
    }


}
