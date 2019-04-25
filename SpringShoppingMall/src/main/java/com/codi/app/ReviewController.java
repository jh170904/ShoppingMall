package com.codi.app;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codi.dao.ReviewDAO;
import com.codi.dto.ReviewDTO;
import com.codi.util.MyUtil;

@Controller("reviewController")
public class ReviewController {
	
	@Autowired
	@Qualifier("reviewDAO")//Bean 객체 생성 
	ReviewDAO dao;
	
	@Autowired()
	MyUtil myUtil;//Bean 객체 생성
	
	@RequestMapping(value = "/reviewList.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String list(ReviewDTO dto, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {
		
		String cp = request.getContextPath();
		
		String pageNum = request.getParameter("pageNum");
		String order = request.getParameter("order");
		
		
		if(order!=null)
			dto.setOrder(order);
		else
			order="recent";
		
		int currentPage = 1;
		
		if(pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		
		int dataCount_yes = dao.getDataCount("aaa","yes");
		int dataCount_no = dao.getDataCount("aaa", "no");
		
		int numPerPage = 7;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount_yes);
		
		if(currentPage>totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		String orderBy;
		if(order.equals("recent"))
			orderBy = "reviewDate desc";
		else if(order.equals("worst"))
			orderBy = "rate";
		else
			orderBy = "rate desc";
		
		List<ReviewDTO> lists = dao.getList("aaa","yes",start, end, orderBy);
		Iterator<ReviewDTO> it = lists.iterator();
		while(it.hasNext()){
			ReviewDTO reviewDTO = it.next();
			reviewDTO.setReviewDate_view(reviewDTO.getReviewDate().substring(0,10));
		}
		
		String listUrl = cp + "/reviewList.action";
		
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		request.setAttribute("lists", lists);
		request.setAttribute("order", order);
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("dataCount_yes", dataCount_yes);
		request.setAttribute("dataCount_no", dataCount_no);
		
		return "review/myReviewList";
	}
	
	@RequestMapping(value = "/reviewPossibleList.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String possibleList(ReviewDTO dto, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {
		
		String cp = request.getContextPath();
		
		String pageNum = request.getParameter("pageNum");
		
		int currentPage = 1;
		
		if(pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		int dataCount_yes = dao.getDataCount("aaa","yes");
		int dataCount_no = dao.getDataCount("aaa", "no");
		
		int numPerPage = 7;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount_no);
		
		if(currentPage>totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		String orderBy = "reviewDate";
		List<ReviewDTO> lists = dao.getList("aaa","no",start, end, orderBy);
		Iterator<ReviewDTO> it = lists.iterator();
		while(it.hasNext()){
			ReviewDTO reviewDTO = it.next();
			reviewDTO.setProductName(URLDecoder.decode(reviewDTO.getProductName(),"UTF-8"));
		}
		
		String listUrl = cp + "/reviewPossibleList.action";
		
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);

		//포워딩 데이터
		request.setAttribute("lists", lists);
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("dataCount_yes", dataCount_yes);
		request.setAttribute("dataCount_no", dataCount_no);
		request.setAttribute("pageNum", pageNum);
		
		return "review/myPossibleReviewList";
	}
	
	@RequestMapping(value = "/reviewWrited.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String writed(ReviewDTO dto, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {
		
		String pageNum = request.getParameter("pageNum");
		
		ReviewDTO writeDTO = (ReviewDTO)dao.getProductList("aaa", dto.getProductId(),dto.getReviewDate());
		
		request.setAttribute("dto", writeDTO);
		request.setAttribute("pageNum", pageNum);
		
		return "review/reviewWrited";
	}
	
	@RequestMapping(value = "/reviewWrited_ok.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String writed_ok(ReviewDTO dto, MultipartHttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {
		
		dto.setUserId("aaa");
		dto.setOriginalName("");
		dto.setSavefileName("");

		Date date = new Date();
		SimpleDateFormat today = new SimpleDateFormat("yyyymmdd24hhmmss");
		String time = today.format(date);
		
		String path = request.getSession().getServletContext().getRealPath("/upload/review");
		
		MultipartFile file = request.getFile("reviewUpload");
		
		//파일이 존재한다면 업로드 하기
		if(file!=null && file.getSize()>0) {

			try {
				
				String saveName = time + file.getOriginalFilename();
				
				File saveFile = new File(path,saveName); 
				file.transferTo(saveFile);
				
				//2. DB에 넣기
				dto.setOriginalName(saveName);
				dto.setSavefileName(saveName);

			} catch (Exception e) {
				System.out.println(e.toString());
			}
			
		}

		dao.insertData(dto);
		
		return "redirect:/reviewList.action";
	}
	
	@RequestMapping(value = "/reviewDeleted.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String deleted(ReviewDTO dto, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {
		
		String path = request.getSession().getServletContext().getRealPath("/upload/review");
		
		String deleteFile = path + "/" + dto.getOriginalName();
		File file = new File(deleteFile);
        
        file.delete();
		
		dao.deleteData("aaa", dto.getProductId(), dto.getReviewDate());
		
		return "redirect:/reviewList.action";
	}
	

}
