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
import com.chengxusheji.service.PurchaseService;
import com.chengxusheji.po.Purchase;
import com.chengxusheji.service.EmployeeService;
import com.chengxusheji.po.Employee;
import com.chengxusheji.service.ProductService;
import com.chengxusheji.po.Product;
import com.chengxusheji.service.SupplierService;
import com.chengxusheji.po.Supplier;

//Purchase管理控制层
@Controller
@RequestMapping("/Purchase")
public class PurchaseController extends BaseController {

    /*业务层对象*/
    @Resource PurchaseService purchaseService;

    @Resource EmployeeService employeeService;
    @Resource ProductService productService;
    @Resource SupplierService supplierService;
	@InitBinder("productObj")
	public void initBinderproductObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("productObj.");
	}
	@InitBinder("supplierObj")
	public void initBindersupplierObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("supplierObj.");
	}
	@InitBinder("employeeObj")
	public void initBinderemployeeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("employeeObj.");
	}
	@InitBinder("purchase")
	public void initBinderPurchase(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("purchase.");
	}
	/*跳转到添加Purchase视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Purchase());
		/*查询所有的Employee信息*/
		List<Employee> employeeList = employeeService.queryAllEmployee();
		request.setAttribute("employeeList", employeeList);
		/*查询所有的Product信息*/
		List<Product> productList = productService.queryAllProduct();
		request.setAttribute("productList", productList);
		/*查询所有的Supplier信息*/
		List<Supplier> supplierList = supplierService.queryAllSupplier();
		request.setAttribute("supplierList", supplierList);
		return "Purchase_add";
	}

	/*客户端ajax方式提交添加进货信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Purchase purchase, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        purchaseService.addPurchase(purchase);
        message = "进货信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询进货信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("productObj") Product productObj,@ModelAttribute("supplierObj") Supplier supplierObj,String purchaseDate,@ModelAttribute("employeeObj") Employee employeeObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (purchaseDate == null) purchaseDate = "";
		if(rows != 0)purchaseService.setRows(rows);
		List<Purchase> purchaseList = purchaseService.queryPurchase(productObj, supplierObj, purchaseDate, employeeObj, page);
	    /*计算总的页数和总的记录数*/
	    purchaseService.queryTotalPageAndRecordNumber(productObj, supplierObj, purchaseDate, employeeObj);
	    /*获取到总的页码数目*/
	    int totalPage = purchaseService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = purchaseService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Purchase purchase:purchaseList) {
			JSONObject jsonPurchase = purchase.getJsonObject();
			jsonArray.put(jsonPurchase);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询进货信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Purchase> purchaseList = purchaseService.queryAllPurchase();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Purchase purchase:purchaseList) {
			JSONObject jsonPurchase = new JSONObject();
			jsonPurchase.accumulate("purchaseId", purchase.getPurchaseId());
			jsonArray.put(jsonPurchase);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询进货信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("productObj") Product productObj,@ModelAttribute("supplierObj") Supplier supplierObj,String purchaseDate,@ModelAttribute("employeeObj") Employee employeeObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (purchaseDate == null) purchaseDate = "";
		List<Purchase> purchaseList = purchaseService.queryPurchase(productObj, supplierObj, purchaseDate, employeeObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    purchaseService.queryTotalPageAndRecordNumber(productObj, supplierObj, purchaseDate, employeeObj);
	    /*获取到总的页码数目*/
	    int totalPage = purchaseService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = purchaseService.getRecordNumber();
	    request.setAttribute("purchaseList",  purchaseList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("productObj", productObj);
	    request.setAttribute("supplierObj", supplierObj);
	    request.setAttribute("purchaseDate", purchaseDate);
	    request.setAttribute("employeeObj", employeeObj);
	    List<Employee> employeeList = employeeService.queryAllEmployee();
	    request.setAttribute("employeeList", employeeList);
	    List<Product> productList = productService.queryAllProduct();
	    request.setAttribute("productList", productList);
	    List<Supplier> supplierList = supplierService.queryAllSupplier();
	    request.setAttribute("supplierList", supplierList);
		return "Purchase/purchase_frontquery_result"; 
	}

     /*前台查询Purchase信息*/
	@RequestMapping(value="/{purchaseId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer purchaseId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键purchaseId获取Purchase对象*/
        Purchase purchase = purchaseService.getPurchase(purchaseId);

        List<Employee> employeeList = employeeService.queryAllEmployee();
        request.setAttribute("employeeList", employeeList);
        List<Product> productList = productService.queryAllProduct();
        request.setAttribute("productList", productList);
        List<Supplier> supplierList = supplierService.queryAllSupplier();
        request.setAttribute("supplierList", supplierList);
        request.setAttribute("purchase",  purchase);
        return "Purchase/purchase_frontshow";
	}

	/*ajax方式显示进货信息修改jsp视图页*/
	@RequestMapping(value="/{purchaseId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer purchaseId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键purchaseId获取Purchase对象*/
        Purchase purchase = purchaseService.getPurchase(purchaseId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonPurchase = purchase.getJsonObject();
		out.println(jsonPurchase.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新进货信息信息*/
	@RequestMapping(value = "/{purchaseId}/update", method = RequestMethod.POST)
	public void update(@Validated Purchase purchase, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			purchaseService.updatePurchase(purchase);
			message = "进货信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "进货信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除进货信息信息*/
	@RequestMapping(value="/{purchaseId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer purchaseId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  purchaseService.deletePurchase(purchaseId);
	            request.setAttribute("message", "进货信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "进货信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条进货信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String purchaseIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = purchaseService.deletePurchases(purchaseIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出进货信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("productObj") Product productObj,@ModelAttribute("supplierObj") Supplier supplierObj,String purchaseDate,@ModelAttribute("employeeObj") Employee employeeObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(purchaseDate == null) purchaseDate = "";
        List<Purchase> purchaseList = purchaseService.queryPurchase(productObj,supplierObj,purchaseDate,employeeObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Purchase信息记录"; 
        String[] headers = { "进货id","进货商品","供应商","进货单价","进货数量","进货日期","进货员工"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<purchaseList.size();i++) {
        	Purchase purchase = purchaseList.get(i); 
        	dataset.add(new String[]{purchase.getPurchaseId() + "",purchase.getProductObj().getProductName(),purchase.getSupplierObj().getSupplierName(),purchase.getPrice() + "",purchase.getCount() + "",purchase.getPurchaseDate(),purchase.getEmployeeObj().getName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Purchase.xls");//filename是下载的xls的名，建议最好用英文 
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
