package servlet.impl;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("MapDAO")
public class MapDAO extends EgovComAbstractDAO {

	@Autowired
	private SqlSessionTemplate session;


	public Map<String, Object> getSdExtent(int sdcdparam) {
		return session.selectOne("map.getSdExtent", sdcdparam);
	}
	
	public Map<String, Object> getSggExtent(int sggcdparam) {
		return session.selectOne("map.getSggExtent", sggcdparam);
	}
}