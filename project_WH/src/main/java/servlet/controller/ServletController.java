package servlet.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import servlet.VO.ServletVO;
import servlet.service.ServletService;

@Controller
public class ServletController {
	@Resource(name = "ServletService")
	private ServletService servletService;
	
	@RequestMapping(value = "/main.do")
	public String mainTest(ModelMap model, @RequestParam(name="loc", required = false, defaultValue = "") String loc) throws Exception {
		System.out.println("sevController.java - mainTest()");
		
		String str = servletService.addStringTest("START! ");
		model.addAttribute("resultStr", str);
		
		List<ServletVO> sdlist = servletService.sdlist();
		model.addAttribute("sdlist",sdlist);
		
		List<ServletVO> sgglist = servletService.sgglist();
		model.addAttribute("sdlist",sgglist);
		
		List<ServletVO> bjdlist = servletService.bjdlist();
		model.addAttribute("bjdlist",bjdlist);
		
		
		return "main/main";
	}
}
