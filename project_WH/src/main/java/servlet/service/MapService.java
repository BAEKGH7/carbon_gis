package servlet.service;

import java.util.Map;

public interface MapService {

	Map<String, Object> getSdExtent(int sdcdparam);
	Map<String, Object> getSggExtent(int sggcdparam);
}
