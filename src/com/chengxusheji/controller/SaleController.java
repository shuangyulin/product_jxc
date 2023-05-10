package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.SaleService;
import com.chengxusheji.po.Sale;
import com.chengxusheji.service.EmployeeService;
import com.chengxusheji.po.Employee;
import com.chengxusheji.service.ProductService;
import com.chengxusheji.po.Product;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Sale管理控制层
@Controller
@RequestMapping("/Sale")
public class SaleController extends BaseController {

    /*业务层对象*/
    @Resource SaleService saleService;

    @Resource EmployeeService employeeService;
    @Resource ProductService productService;
    @Resource UserInfoService userInfoService;
	@InitBinder("productObj")
	public void initBinderproductObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("productObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("employeeObj")
	public void initBinderemployeeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("employeeObj.");
	}
	@InitBinder("sale")
	public void initBinderSale(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("sale.");
	}
	/*跳转到添加Sale视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Sale());
		/*查询所有的Employee信息*/
		List<Employee> employeeList = employeeService.queryAllEmployee();
		request.setAttribute("employeeList", employeeList);
		/*查询所有的Product信息*/
		List<Product> productList = productService.queryAllProduct();
		request.setAttribute("productList", productList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Sale_add";
	}

	/*客户端ajax方式提交添加销售信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Sale sale, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        saleService.addSale(sale);
        message = "销售信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询销售信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("productObj") Product productObj,@ModelAttribute("userObj") UserInfo userObj,String saleDate,@ModelAttribute("employeeObj") Employee employeeObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (saleDate == null) saleDate = "";
		if(rows != 0)saleService.setRows(rows);
		List<Sale> saleList = saleService.querySale(productObj, userObj, saleDate, employeeObj, page);
	    /*计算总的页数和总的记录数*/
	    saleService.queryTotalPageAndRecordNumber(productObj, userObj, saleDate, employeeObj);
	    /*获取到总的页码数目*/
	    int totalPage = saleService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = saleService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Sale sale:saleList) {
			JSONObject jsonSale = sale.getJsonObject();
			jsonArray.put(jsonSale);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询销售信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Sale> saleList = saleService.queryAllSale();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Sale sale:saleList) {
			JSONObject jsonSale = new JSONObject();
			jsonSale.accumulate("saleId", sale.getSaleId());
			jsonArray.put(jsonSale);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询销售信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("productObj") Product productObj,@ModelAttribute("userObj") UserInfo userObj,String saleDate,@ModelAttribute("employeeObj") Employee employeeObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (saleDate == null) saleDate = "";
		List<Sale> saleList = saleService.querySale(productObj, userObj, saleDate, employeeObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    saleService.queryTotalPageAndRecordNumber(productObj, userObj, saleDate, employeeObj);
	    /*获取到总的页码数目*/
	    int totalPage = saleService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = saleService.getRecordNumber();
	    request.setAttribute("saleList",  saleList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("productObj", productObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("saleDate", saleDate);
	    request.setAttribute("employeeObj", employeeObj);
	    List<Employee> employeeList = employeeService.queryAllEmployee();
	    request.setAttribute("employeeList", employeeList);
	    List<Product> productList = productService.queryAllProduct();
	    request.setAttribute("productList", productList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Sale/sale_frontquery_result"; 
	}

     /*前台查询Sale信息*/
	@RequestMapping(value="/{saleId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer saleId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键saleId获取Sale对象*/
        Sale sale = saleService.getSale(saleId);

        List<Employee> employeeList = employeeService.queryAllEmployee();
        request.setAttribute("employeeList", employeeList);
        List<Product> productList = productService.queryAllProduct();
        request.setAttribute("productList", productList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("sale",  sale);
        return "Sale/sale_frontshow";
	}

	/*ajax方式显示销售信息修改jsp视图页*/
	@RequestMapping(value="/{saleId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer saleId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键saleId获取Sale对象*/
        Sale sale = saleService.getSale(saleId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonSale = sale.getJsonObject();
		out.println(jsonSale.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新销售信息信息*/
	@RequestMapping(value = "/{saleId}/update", method = RequestMethod.POST)
	public void update(@Validated Sale sale, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			saleService.updateSale(sale);
			message = "销售信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "销售信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除销售信息信息*/
	@RequestMapping(value="/{saleId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer saleId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  saleService.deleteSale(saleId);
	            request.setAttribute("message", "销售信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "销售信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条销售信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String saleIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = saleService.deleteSales(saleIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出销售信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("productObj") Product productObj,@ModelAttribute("userObj") UserInfo userObj,String saleDate,@ModelAttribute("employeeObj") Employee employeeObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(saleDate == null) saleDate = "";
        List<Sale> saleList = saleService.querySale(productObj,userObj,saleDate,employeeObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Sale信息记录"; 
        String[] headers = { "销售id","销售商品","销售客户","销售单价","销售数量","销售日期","销售员工"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<saleList.size();i++) {
        	Sale sale = saleList.get(i); 
        	dataset.add(new String[]{sale.getSaleId() + "",sale.getProductObj().getProductName(),sale.getUserObj().getName(),sale.getPrice() + "",sale.getCount() + "",sale.getSaleDate(),sale.getEmployeeObj().getName()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Sale.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
