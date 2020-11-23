package com.seeyon.apps.gwjk.manager;

import com.seeyon.ctp.common.exceptions.BusinessException;
import com.seeyon.ctp.common.template.vo.TemplateTreeVo;
import com.seeyon.ctp.util.FlipInfo;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface GwJkManager {
    FlipInfo toGwjk(FlipInfo fi, Map<String, String> query) throws BusinessException, SQLException;

    FlipInfo toSwfkxx(FlipInfo fi, Map<String, String> query) throws BusinessException, SQLException;


    FlipInfo toXtbgJkList(FlipInfo fi, Map<String, String> query) throws BusinessException, SQLException;

    FlipInfo toXnqsJkList(FlipInfo fi, Map<String, String> query) throws BusinessException, SQLException;
}
