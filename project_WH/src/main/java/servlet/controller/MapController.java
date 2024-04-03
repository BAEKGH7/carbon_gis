package servlet.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import servlet.service.MapService;
import servlet.util.Util;

@Controller
public class MapController {
	
	@Resource(name="MapService")
	private MapService mapService;

	@RequestMapping(value = "/ZoomSd.do", method = RequestMethod.POST,  produces = "application/json;charset=UTF8")
	 @ResponseBody 
	 public String sdSelect(@RequestParam("sdcdparam") String sdcdparam) {
	

		Map<String, Object> sdExtent = mapService.getSdExtent(Util.str2int(sdcdparam));
		JSONObject json = new JSONObject();
		json.put("sdExtent", sdExtent);
		
		return json.toString();
	}
	

	@ResponseBody
	@RequestMapping(value="/ZoomSgg.do", method=RequestMethod.POST, produces = "application/json; charset=UTF-8")
	public String sggSelect(@RequestParam(value="sggcdparam") String sggcdparam) {
		
		Map<String, Object> sggExtent = mapService.getSggExtent(Util.str2int(sggcdparam));
		JSONObject json = new JSONObject();
		json.put("sggExtent", sggExtent);
		
		
		return json.toString();
	}
	
	
}
