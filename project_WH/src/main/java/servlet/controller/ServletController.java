package servlet.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import servlet.VO.ServletVO;
import servlet.service.MapService;
import servlet.service.ServletService;
import servlet.util.Util;

@Controller
public class ServletController {
	
	@Resource(name="MapService")
	private MapService mapService;
	
	@Resource(name = "ServletService")
	private ServletService servletService;
	
	@RequestMapping(value = {"/main.do"}, method = RequestMethod.GET)
	public String mainTest(ModelMap model) throws Exception {
		System.out.println("sevController.java - mainTest()");
		
		String str = servletService.addStringTest("START! ");
		model.addAttribute("resultStr", str);
		
		System.out.println("resultStr");
		
		
		List<ServletVO> sdlist = servletService.sdlist();
		model.addAttribute("sdlist",sdlist);
		
		System.out.println("sdlist");
		
		/*
		 * List<ServletVO> sgglist = servletService.sgglist();
		 * model.addAttribute("sgglist",sgglist);
		 * 
		 * System.out.println("sgglist");
		 * 
		 * List<ServletVO> bjdlist = servletService.bjdlist();
		 * model.addAttribute("bjdlist",bjdlist);
		 * 
		 * System.out.println("bjdlist");
		 */
		
		return "main/main";
	}
	
	@RequestMapping(value = "/selectedSD.do", method = RequestMethod.POST,  produces = "application/json;charset=UTF8")
	 @ResponseBody 
	 public List<ServletVO> testPage(@RequestParam("sdcdparam") String sdcdparam) {
	      
	      System.out.println(sdcdparam);
	      
	      List<ServletVO> sgglist = servletService.sgglist(sdcdparam);
	      System.out.println(sgglist);
	         

	      
	      return sgglist;
	   }

	@RequestMapping(value = "/selectedSgg.do", method = RequestMethod.POST,  produces = "application/json;charset=UTF8")
	 @ResponseBody 
	 public List<ServletVO> testPage2(@RequestParam("sggcdparam") String sggcdparam) {
	      
	      System.out.println(sggcdparam);
	      
	      List<ServletVO> bjdlist = servletService.bjdlist(sggcdparam);
	      System.out.println(bjdlist.size());
	      
	      return bjdlist;
	   }
	
	
}
