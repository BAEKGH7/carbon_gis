package servlet.controller;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import servlet.service.FileService;
import servlet.service.MapService;
import servlet.util.Util;

@Controller
public class MapController {
	
	@Resource(name="MapService")
	private MapService mapService;
	
	@Resource(name="FileService")
	private FileService fileService;

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
	// 파일 업로드
	@ResponseBody
	@RequestMapping(value = "/uploadTxt.do", method = RequestMethod.POST)
	//public String uploadTxt(MultipartHttpServletRequest request) throws IOException {
	public String uploadTxt(@RequestParam("file") MultipartFile file) throws IOException {
		//System.out.println(file);
		int result = 0;
		
		long startTime = System.currentTimeMillis();
		if(Util.isValidTxtFile(file)) {
			System.out.println(file.getName());
			System.out.println(file.getSize());
			System.out.println(file.getContentType());
			System.out.println(file.getOriginalFilename());
			
			result = fileService.uploadFile(file);
			long endTime = System.currentTimeMillis();
			long timeElapsed = endTime - startTime;
			//System.out.println("처리 시간(분): " + (processingTime));
			
			double processingTime = (double) timeElapsed / 1000;
			
			JSONObject json = new JSONObject();

			json.put("result", result);
			json.put("timeElapsed", processingTime);

			
			return json.toString();
			
		} else {
			return String.valueOf(result);
		}
	}
	
}
