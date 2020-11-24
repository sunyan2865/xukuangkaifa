package com.seeyon.apps.xntl.manager;

import com.seeyon.ctp.common.exceptions.BusinessException;
import com.seeyon.ctp.util.FlipInfo;

import java.sql.SQLException;
import java.util.Map;

public interface XntlManager {
    FlipInfo toXntx(FlipInfo fi, Map<String, String> query) throws BusinessException, SQLException;
}
