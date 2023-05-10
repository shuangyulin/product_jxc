package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Supplier;

public interface SupplierMapper {
	/*添加供应商信息*/
	public void addSupplier(Supplier supplier) throws Exception;

	/*按照查询条件分页查询供应商记录*/
	public ArrayList<Supplier> querySupplier(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有供应商记录*/
	public ArrayList<Supplier> querySupplierList(@Param("where") String where) throws Exception;

	/*按照查询条件的供应商记录数*/
	public int querySupplierCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条供应商记录*/
	public Supplier getSupplier(int supplierId) throws Exception;

	/*更新供应商记录*/
	public void updateSupplier(Supplier supplier) throws Exception;

	/*删除供应商记录*/
	public void deleteSupplier(int supplierId) throws Exception;

}
