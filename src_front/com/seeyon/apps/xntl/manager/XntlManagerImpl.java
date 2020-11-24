package com.seeyon.apps.xntl.manager;

import com.seeyon.ctp.common.exceptions.BusinessException;
import com.seeyon.ctp.util.FlipInfo;
import com.seeyon.ctp.util.JDBCAgent;
import com.seeyon.ctp.util.annotation.AjaxAccess;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class XntlManagerImpl implements XntlManager {

    @Override
    @AjaxAccess
    @SuppressWarnings("unchecked")
    public FlipInfo toXntx(FlipInfo flipInfo, Map<String,String> query) throws SQLException, BusinessException {

        StringBuffer sql=new StringBuffer(" select * from (" +
                " select id,f.field0001 xm,f.field0002 szbm,f.field0006 bmbm,f.field0003 ch,f.field0004 dh,f.field0005 email from formmain_0918 f  " +
                " )t   ");
        if(null != query.get("xm") &&  !(query.get("xm").toString().equals(""))) {
            sql.append(" where 1=1  and (xm like '%"+query.get("xm")+"%' or szbm like '%"+query.get("xm")+"%' or ch like '%"+query.get("xm")+"%' or dh like '%"+query.get("xm")+"%' or email like '%"+query.get("xm")+"%') ");
        }else{
            sql.append(" where 1=2  ");
        }
        sql.append(" order by szbm");
        List<Map<String, Object>> swlist = null;
        JDBCAgent jdbcAgent = new JDBCAgent(true, false);
        try {
            jdbcAgent.execute(sql.toString());
            swlist = jdbcAgent.resultSetToList();

            int page = flipInfo.getPage();
            int size = 17;
            flipInfo.setTotal(swlist.size());
            List newList = new ArrayList();
            int currIdx = page > 1 ? (page - 1) * size : 0;
            for (int i = 0; i < size && i < (swlist).size() - currIdx; ++i) {
                newList.add((swlist).get(currIdx + i));
            }
            flipInfo.setData(newList);

        } catch (BusinessException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            jdbcAgent.close();
        }

        return flipInfo;

    }



}
