package servlet.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import servlet.VO.ServletVO;
import servlet.service.ServletService;

@Controller
public class ServletController {
	@Resource(name = "ServletService")
	private ServletService servletService;
	
	@RequestMapping(value = {"/main.do", "/selectSgg.do"}, method = {RequestMethod.GET, RequestMethod.POST})
	public String mainTest(ModelMap model, @RequestParam(name="sd", required = false, defaultValue = "") String sd) throws Exception {
		System.out.println("sevController.java - mainTest()");
		
		String str = servletService.addStringTest("START! ");
		model.addAttribute("resultStr", str);
		
		System.out.println("resultStr");
		
		
		List<ServletVO> sdlist = servletService.sdlist();
		model.addAttribute("sdlist",sdlist);
		
		System.out.println("sdlist");
		
		List<ServletVO> sgglist = servletService.sgglist();
		model.addAttribute("sgglist",sgglist);
		
		System.out.println("sgglist");
		
		List<ServletVO> bjdlist = servletService.bjdlist();
		model.addAttribute("bjdlist",bjdlist);
		
		System.out.println("bjdlist");
		
		return "main/main";
	}
	
	
	
}
