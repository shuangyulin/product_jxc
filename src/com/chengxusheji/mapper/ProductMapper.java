package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Product;

public interface ProductMapper {
	/*添加商品信息信息*/
	public void addProduct(Product product) throws Exception;

	/*按照查询条件分页查询商品信息记录*/
	public ArrayList<Product> queryProduct(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有商品信息记录*/
	public ArrayList<Product> queryProductList(@Param("where") String where) throws Exception;

	/*按照查询条件的商品信息记录数*/
	public int queryProductCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条商品信息记录*/
	public Product getProduct(String productNo) throws Exception;

	/*更新商品信息记录*/
	public void updateProduct(Product product) throws Exception;

	/*删除商品信息记录*/
	public void deleteProduct(String productNo) throws Exception;

}
