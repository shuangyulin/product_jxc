package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.ProductClass;
import com.chengxusheji.po.Product;

import com.chengxusheji.mapper.ProductMapper;
@Service
public class ProductService {

	@Resource ProductMapper productMapper;
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

    /*添加商品信息记录*/
    public void addProduct(Product product) throws Exception {
    	productMapper.addProduct(product);
    }

    /*按照查询条件分页查询商品信息记录*/
    public ArrayList<Product> queryProduct(String productNo,ProductClass productClassObj,String productName,String madeDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!productNo.equals("")) where = where + " and t_product.productNo like '%" + productNo + "%'";
    	if(null != productClassObj && productClassObj.getProductClassId()!= null && productClassObj.getProductClassId()!= 0)  where += " and t_product.productClassObj=" + productClassObj.getProductClassId();
    	if(!productName.equals("")) where = where + " and t_product.productName like '%" + productName + "%'";
    	if(!madeDate.equals("")) where = where + " and t_product.madeDate like '%" + madeDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return productMapper.queryProduct(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Product> queryProduct(String productNo,ProductClass productClassObj,String productName,String madeDate) throws Exception  { 
     	String where = "where 1=1";
    	if(!productNo.equals("")) where = where + " and t_product.productNo like '%" + productNo + "%'";
    	if(null != productClassObj && productClassObj.getProductClassId()!= null && productClassObj.getProductClassId()!= 0)  where += " and t_product.productClassObj=" + productClassObj.getProductClassId();
    	if(!productName.equals("")) where = where + " and t_product.productName like '%" + productName + "%'";
    	if(!madeDate.equals("")) where = where + " and t_product.madeDate like '%" + madeDate + "%'";
    	return productMapper.queryProductList(where);
    }

    /*查询所有商品信息记录*/
    public ArrayList<Product> queryAllProduct()  throws Exception {
        return productMapper.queryProductList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String productNo,ProductClass productClassObj,String productName,String madeDate) throws Exception {
     	String where = "where 1=1";
    	if(!productNo.equals("")) where = where + " and t_product.productNo like '%" + productNo + "%'";
    	if(null != productClassObj && productClassObj.getProductClassId()!= null && productClassObj.getProductClassId()!= 0)  where += " and t_product.productClassObj=" + productClassObj.getProductClassId();
    	if(!productName.equals("")) where = where + " and t_product.productName like '%" + productName + "%'";
    	if(!madeDate.equals("")) where = where + " and t_product.madeDate like '%" + madeDate + "%'";
        recordNumber = productMapper.queryProductCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取商品信息记录*/
    public Product getProduct(String productNo) throws Exception  {
        Product product = productMapper.getProduct(productNo);
        return product;
    }

    /*更新商品信息记录*/
    public void updateProduct(Product product) throws Exception {
        productMapper.updateProduct(product);
    }

    /*删除一条商品信息记录*/
    public void deleteProduct (String productNo) throws Exception {
        productMapper.deleteProduct(productNo);
    }

    /*删除多条商品信息信息*/
    public int deleteProducts (String productNos) throws Exception {
    	String _productNos[] = productNos.split(",");
    	for(String _productNo: _productNos) {
    		productMapper.deleteProduct(_productNo);
    	}
    	return _productNos.length;
    }
}
