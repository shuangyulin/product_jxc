package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Product;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Employee;
import com.chengxusheji.po.Sale;

import com.chengxusheji.mapper.SaleMapper;
@Service
public class SaleService {

	@Resource SaleMapper saleMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加销售信息记录*/
    public void addSale(Sale sale) throws Exception {
    	saleMapper.addSale(sale);
    }

    /*按照查询条件分页查询销售信息记录*/
    public ArrayList<Sale> querySale(Product productObj,UserInfo userObj,String saleDate,Employee employeeObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != productObj &&  productObj.getProductNo() != null  && !productObj.getProductNo().equals(""))  where += " and t_sale.productObj='" + productObj.getProductNo() + "'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_sale.userObj='" + userObj.getUser_name() + "'";
    	if(!saleDate.equals("")) where = where + " and t_sale.saleDate like '%" + saleDate + "%'";
    	if(null != employeeObj &&  employeeObj.getEmployeeNo() != null  && !employeeObj.getEmployeeNo().equals(""))  where += " and t_sale.employeeObj='" + employeeObj.getEmployeeNo() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return saleMapper.querySale(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Sale> querySale(Product productObj,UserInfo userObj,String saleDate,Employee employeeObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != productObj &&  productObj.getProductNo() != null && !productObj.getProductNo().equals(""))  where += " and t_sale.productObj='" + productObj.getProductNo() + "'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_sale.userObj='" + userObj.getUser_name() + "'";
    	if(!saleDate.equals("")) where = where + " and t_sale.saleDate like '%" + saleDate + "%'";
    	if(null != employeeObj &&  employeeObj.getEmployeeNo() != null && !employeeObj.getEmployeeNo().equals(""))  where += " and t_sale.employeeObj='" + employeeObj.getEmployeeNo() + "'";
    	return saleMapper.querySaleList(where);
    }

    /*查询所有销售信息记录*/
    public ArrayList<Sale> queryAllSale()  throws Exception {
        return saleMapper.querySaleList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Product productObj,UserInfo userObj,String saleDate,Employee employeeObj) throws Exception {
     	String where = "where 1=1";
    	if(null != productObj &&  productObj.getProductNo() != null && !productObj.getProductNo().equals(""))  where += " and t_sale.productObj='" + productObj.getProductNo() + "'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_sale.userObj='" + userObj.getUser_name() + "'";
    	if(!saleDate.equals("")) where = where + " and t_sale.saleDate like '%" + saleDate + "%'";
    	if(null != employeeObj &&  employeeObj.getEmployeeNo() != null && !employeeObj.getEmployeeNo().equals(""))  where += " and t_sale.employeeObj='" + employeeObj.getEmployeeNo() + "'";
        recordNumber = saleMapper.querySaleCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取销售信息记录*/
    public Sale getSale(int saleId) throws Exception  {
        Sale sale = saleMapper.getSale(saleId);
        return sale;
    }

    /*更新销售信息记录*/
    public void updateSale(Sale sale) throws Exception {
        saleMapper.updateSale(sale);
    }

    /*删除一条销售信息记录*/
    public void deleteSale (int saleId) throws Exception {
        saleMapper.deleteSale(saleId);
    }

    /*删除多条销售信息信息*/
    public int deleteSales (String saleIds) throws Exception {
    	String _saleIds[] = saleIds.split(",");
    	for(String _saleId: _saleIds) {
    		saleMapper.deleteSale(Integer.parseInt(_saleId));
    	}
    	return _saleIds.length;
    }
}
