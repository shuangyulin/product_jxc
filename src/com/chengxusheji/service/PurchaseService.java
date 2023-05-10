package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Product;
import com.chengxusheji.po.Supplier;
import com.chengxusheji.po.Employee;
import com.chengxusheji.po.Purchase;

import com.chengxusheji.mapper.PurchaseMapper;
@Service
public class PurchaseService {

	@Resource PurchaseMapper purchaseMapper;
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

    /*添加进货信息记录*/
    public void addPurchase(Purchase purchase) throws Exception {
    	purchaseMapper.addPurchase(purchase);
    }

    /*按照查询条件分页查询进货信息记录*/
    public ArrayList<Purchase> queryPurchase(Product productObj,Supplier supplierObj,String purchaseDate,Employee employeeObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != productObj &&  productObj.getProductNo() != null  && !productObj.getProductNo().equals(""))  where += " and t_purchase.productObj='" + productObj.getProductNo() + "'";
    	if(null != supplierObj && supplierObj.getSupplierId()!= null && supplierObj.getSupplierId()!= 0)  where += " and t_purchase.supplierObj=" + supplierObj.getSupplierId();
    	if(!purchaseDate.equals("")) where = where + " and t_purchase.purchaseDate like '%" + purchaseDate + "%'";
    	if(null != employeeObj &&  employeeObj.getEmployeeNo() != null  && !employeeObj.getEmployeeNo().equals(""))  where += " and t_purchase.employeeObj='" + employeeObj.getEmployeeNo() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return purchaseMapper.queryPurchase(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Purchase> queryPurchase(Product productObj,Supplier supplierObj,String purchaseDate,Employee employeeObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != productObj &&  productObj.getProductNo() != null && !productObj.getProductNo().equals(""))  where += " and t_purchase.productObj='" + productObj.getProductNo() + "'";
    	if(null != supplierObj && supplierObj.getSupplierId()!= null && supplierObj.getSupplierId()!= 0)  where += " and t_purchase.supplierObj=" + supplierObj.getSupplierId();
    	if(!purchaseDate.equals("")) where = where + " and t_purchase.purchaseDate like '%" + purchaseDate + "%'";
    	if(null != employeeObj &&  employeeObj.getEmployeeNo() != null && !employeeObj.getEmployeeNo().equals(""))  where += " and t_purchase.employeeObj='" + employeeObj.getEmployeeNo() + "'";
    	return purchaseMapper.queryPurchaseList(where);
    }

    /*查询所有进货信息记录*/
    public ArrayList<Purchase> queryAllPurchase()  throws Exception {
        return purchaseMapper.queryPurchaseList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Product productObj,Supplier supplierObj,String purchaseDate,Employee employeeObj) throws Exception {
     	String where = "where 1=1";
    	if(null != productObj &&  productObj.getProductNo() != null && !productObj.getProductNo().equals(""))  where += " and t_purchase.productObj='" + productObj.getProductNo() + "'";
    	if(null != supplierObj && supplierObj.getSupplierId()!= null && supplierObj.getSupplierId()!= 0)  where += " and t_purchase.supplierObj=" + supplierObj.getSupplierId();
    	if(!purchaseDate.equals("")) where = where + " and t_purchase.purchaseDate like '%" + purchaseDate + "%'";
    	if(null != employeeObj &&  employeeObj.getEmployeeNo() != null && !employeeObj.getEmployeeNo().equals(""))  where += " and t_purchase.employeeObj='" + employeeObj.getEmployeeNo() + "'";
        recordNumber = purchaseMapper.queryPurchaseCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取进货信息记录*/
    public Purchase getPurchase(int purchaseId) throws Exception  {
        Purchase purchase = purchaseMapper.getPurchase(purchaseId);
        return purchase;
    }

    /*更新进货信息记录*/
    public void updatePurchase(Purchase purchase) throws Exception {
        purchaseMapper.updatePurchase(purchase);
    }

    /*删除一条进货信息记录*/
    public void deletePurchase (int purchaseId) throws Exception {
        purchaseMapper.deletePurchase(purchaseId);
    }

    /*删除多条进货信息信息*/
    public int deletePurchases (String purchaseIds) throws Exception {
    	String _purchaseIds[] = purchaseIds.split(",");
    	for(String _purchaseId: _purchaseIds) {
    		purchaseMapper.deletePurchase(Integer.parseInt(_purchaseId));
    	}
    	return _purchaseIds.length;
    }
}
