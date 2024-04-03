package servlet.service;

import java.util.List;
import java.util.Map;

import servlet.VO.ServletVO;

public interface ServletService {
	String addStringTest(String str) throws Exception;


	List<ServletVO> sdlist();
	
	List<ServletVO> sgglist(String sdcdparam);
	
	List<ServletVO> bjdlist(String sggcdparam);

}
