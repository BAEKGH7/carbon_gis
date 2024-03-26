package servlet.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import servlet.VO.ServletVO;
import servlet.service.ServletService;

@Service("ServletService")
public class ServletImpl extends EgovAbstractServiceImpl implements ServletService{
	
	@Resource(name="ServletDAO")
	private ServletDAO dao;
	
	@Override
	public String addStringTest(String str) throws Exception {
		List<EgovMap> mediaType = dao.selectAll();
		return str + " -> testImpl ";
	}
	
	@Override
	public List<ServletVO> sdlist() {
		return dao.sdlist();
	}
	@Override
	public List<ServletVO> sgglist() {
		return dao.sgglist();
		}

	@Override
	public List<ServletVO> bjdlist() {
		return dao.bjdlist();
		}
}
