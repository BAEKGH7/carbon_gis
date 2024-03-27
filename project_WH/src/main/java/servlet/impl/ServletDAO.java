package servlet.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import servlet.VO.ServletVO;

@Repository("ServletDAO")
public class ServletDAO extends EgovComAbstractDAO {

	@Autowired
	private SqlSessionTemplate session;

	public List<EgovMap> selectAll() {
		return selectList("servlet.serVletTest");
	}

	public List<ServletVO> sdlist() {
		return selectList("servlet.tl_sd");
	}


	public List<ServletVO> sgglist(String sdcdparam) {
		return selectList("servlet.tl_sgg", sdcdparam);
	}


	public List<ServletVO> bjdlist() {
		return selectList("servlet.tl_bjd");
	}

}
