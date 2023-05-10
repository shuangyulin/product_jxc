package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Supplier;

import com.chengxusheji.mapper.SupplierMapper;
@Service
public class SupplierService {

	@Resource SupplierMapper supplierMapper;
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

    /*添加供应商记录*/
    public void addSupplier(Supplier supplier) throws Exception {
    	supplierMapper.addSupplier(supplier);
    }

    /*按照查询条件分页查询供应商记录*/
    public ArrayList<Supplier> querySupplier(String supplierName,String personName,String telephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!supplierName.equals("")) where = where + " and t_supplier.supplierName like '%" + supplierName + "%'";
    	if(!personName.equals("")) where = where + " and t_supplier.personName like '%" + personName + "%'";
    	if(!telephone.equals("")) where = where + " and t_supplier.telephone like '%" + telephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return supplierMapper.querySupplier(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Supplier> querySupplier(String supplierName,String personName,String telephone) throws Exception  { 
     	String where = "where 1=1";
    	if(!supplierName.equals("")) where = where + " and t_supplier.supplierName like '%" + supplierName + "%'";
    	if(!personName.equals("")) where = where + " and t_supplier.personName like '%" + personName + "%'";
    	if(!telephone.equals("")) where = where + " and t_supplier.telephone like '%" + telephone + "%'";
    	return supplierMapper.querySupplierList(where);
    }

    /*查询所有供应商记录*/
    public ArrayList<Supplier> queryAllSupplier()  throws Exception {
        return supplierMapper.querySupplierList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String supplierName,String personName,String telephone) throws Exception {
     	String where = "where 1=1";
    	if(!supplierName.equals("")) where = where + " and t_supplier.supplierName like '%" + supplierName + "%'";
    	if(!personName.equals("")) where = where + " and t_supplier.personName like '%" + personName + "%'";
    	if(!telephone.equals("")) where = where + " and t_supplier.telephone like '%" + telephone + "%'";
        recordNumber = supplierMapper.querySupplierCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取供应商记录*/
    public Supplier getSupplier(int supplierId) throws Exception  {
        Supplier supplier = supplierMapper.getSupplier(supplierId);
        return supplier;
    }

    /*更新供应商记录*/
    public void updateSupplier(Supplier supplier) throws Exception {
        supplierMapper.updateSupplier(supplier);
    }

    /*删除一条供应商记录*/
    public void deleteSupplier (int supplierId) throws Exception {
        supplierMapper.deleteSupplier(supplierId);
    }

    /*删除多条供应商信息*/
    public int deleteSuppliers (String supplierIds) throws Exception {
    	String _supplierIds[] = supplierIds.split(",");
    	for(String _supplierId: _supplierIds) {
    		supplierMapper.deleteSupplier(Integer.parseInt(_supplierId));
    	}
    	return _supplierIds.length;
    }
}
