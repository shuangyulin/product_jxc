package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Sale;

public interface SaleMapper {
	/*添加销售信息信息*/
	public void addSale(Sale sale) throws Exception;

	/*按照查询条件分页查询销售信息记录*/
	public ArrayList<Sale> querySale(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有销售信息记录*/
	public ArrayList<Sale> querySaleList(@Param("where") String where) throws Exception;

	/*按照查询条件的销售信息记录数*/
	public int querySaleCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条销售信息记录*/
	public Sale getSale(int saleId) throws Exception;

	/*更新销售信息记录*/
	public void updateSale(Sale sale) throws Exception;

	/*删除销售信息记录*/
	public void deleteSale(int saleId) throws Exception;

}
