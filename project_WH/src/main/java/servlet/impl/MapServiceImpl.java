package servlet.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import servlet.service.MapService;

@Service("MapService")
public class MapServiceImpl extends EgovAbstractServiceImpl implements MapService {
	
	@Resource(name="MapDAO")
	private MapDAO mapDAO;

	
	@Override
	public Map<String, Object> getSdExtent(int sdcdparam) {
		return mapDAO.getSdExtent(sdcdparam);
	}

	@Override
	public Map<String, Object> getSggExtent(int sggcdparam) {
		return mapDAO.getSggExtent(sggcdparam);
	}
	
	

}