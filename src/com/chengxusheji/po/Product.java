package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Product {
    /*商品编号*/
    @NotEmpty(message="商品编号不能为空")
    private String productNo;
    public String getProductNo(){
        return productNo;
    }
    public void setProductNo(String productNo){
        this.productNo = productNo;
    }

    /*商品类别*/
    private ProductClass productClassObj;
    public ProductClass getProductClassObj() {
        return productClassObj;
    }
    public void setProductClassObj(ProductClass productClassObj) {
        this.productClassObj = productClassObj;
    }

    /*商品名称*/
    @NotEmpty(message="商品名称不能为空")
    private String productName;
    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    /*产品图片*/
    private String productPhoto;
    public String getProductPhoto() {
        return productPhoto;
    }
    public void setProductPhoto(String productPhoto) {
        this.productPhoto = productPhoto;
    }

    /*商品库存*/
    @NotNull(message="必须输入商品库存")
    private Integer count;
    public Integer getCount() {
        return count;
    }
    public void setCount(Integer count) {
        this.count = count;
    }

    /*市场价*/
    @NotNull(message="必须输入市场价")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*产地*/
    private String madeAddress;
    public String getMadeAddress() {
        return madeAddress;
    }
    public void setMadeAddress(String madeAddress) {
        this.madeAddress = madeAddress;
    }

    /*规格*/
    private String guige;
    public String getGuige() {
        return guige;
    }
    public void setGuige(String guige) {
        this.guige = guige;
    }

    /*生产日期*/
    @NotEmpty(message="生产日期不能为空")
    private String madeDate;
    public String getMadeDate() {
        return madeDate;
    }
    public void setMadeDate(String madeDate) {
        this.madeDate = madeDate;
    }

    /*有效期*/
    private String yxq;
    public String getYxq() {
        return yxq;
    }
    public void setYxq(String yxq) {
        this.yxq = yxq;
    }

    /*备注*/
    private String beizhu;
    public String getBeizhu() {
        return beizhu;
    }
    public void setBeizhu(String beizhu) {
        this.beizhu = beizhu;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonProduct=new JSONObject(); 
		jsonProduct.accumulate("productNo", this.getProductNo());
		jsonProduct.accumulate("productClassObj", this.getProductClassObj().getProductClassName());
		jsonProduct.accumulate("productClassObjPri", this.getProductClassObj().getProductClassId());
		jsonProduct.accumulate("productName", this.getProductName());
		jsonProduct.accumulate("productPhoto", this.getProductPhoto());
		jsonProduct.accumulate("count", this.getCount());
		jsonProduct.accumulate("price", this.getPrice());
		jsonProduct.accumulate("madeAddress", this.getMadeAddress());
		jsonProduct.accumulate("guige", this.getGuige());
		jsonProduct.accumulate("madeDate", this.getMadeDate().length()>19?this.getMadeDate().substring(0,19):this.getMadeDate());
		jsonProduct.accumulate("yxq", this.getYxq());
		jsonProduct.accumulate("beizhu", this.getBeizhu());
		return jsonProduct;
    }}