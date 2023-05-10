package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Sale {
    /*销售id*/
    private Integer saleId;
    public Integer getSaleId(){
        return saleId;
    }
    public void setSaleId(Integer saleId){
        this.saleId = saleId;
    }

    /*销售商品*/
    private Product productObj;
    public Product getProductObj() {
        return productObj;
    }
    public void setProductObj(Product productObj) {
        this.productObj = productObj;
    }

    /*销售客户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*销售单价*/
    @NotNull(message="必须输入销售单价")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*销售数量*/
    @NotNull(message="必须输入销售数量")
    private Integer count;
    public Integer getCount() {
        return count;
    }
    public void setCount(Integer count) {
        this.count = count;
    }

    /*销售日期*/
    @NotEmpty(message="销售日期不能为空")
    private String saleDate;
    public String getSaleDate() {
        return saleDate;
    }
    public void setSaleDate(String saleDate) {
        this.saleDate = saleDate;
    }

    /*销售员工*/
    private Employee employeeObj;
    public Employee getEmployeeObj() {
        return employeeObj;
    }
    public void setEmployeeObj(Employee employeeObj) {
        this.employeeObj = employeeObj;
    }

    /*备注*/
    private String memo;
    public String getMemo() {
        return memo;
    }
    public void setMemo(String memo) {
        this.memo = memo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSale=new JSONObject(); 
		jsonSale.accumulate("saleId", this.getSaleId());
		jsonSale.accumulate("productObj", this.getProductObj().getProductName());
		jsonSale.accumulate("productObjPri", this.getProductObj().getProductNo());
		jsonSale.accumulate("userObj", this.getUserObj().getName());
		jsonSale.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonSale.accumulate("price", this.getPrice());
		jsonSale.accumulate("count", this.getCount());
		jsonSale.accumulate("saleDate", this.getSaleDate().length()>19?this.getSaleDate().substring(0,19):this.getSaleDate());
		jsonSale.accumulate("employeeObj", this.getEmployeeObj().getName());
		jsonSale.accumulate("employeeObjPri", this.getEmployeeObj().getEmployeeNo());
		jsonSale.accumulate("memo", this.getMemo());
		return jsonSale;
    }}