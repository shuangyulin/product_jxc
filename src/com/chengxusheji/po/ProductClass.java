package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ProductClass {
    /*商品类别id*/
    private Integer productClassId;
    public Integer getProductClassId(){
        return productClassId;
    }
    public void setProductClassId(Integer productClassId){
        this.productClassId = productClassId;
    }

    /*商品类别名称*/
    @NotEmpty(message="商品类别名称不能为空")
    private String productClassName;
    public String getProductClassName() {
        return productClassName;
    }
    public void setProductClassName(String productClassName) {
        this.productClassName = productClassName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonProductClass=new JSONObject(); 
		jsonProductClass.accumulate("productClassId", this.getProductClassId());
		jsonProductClass.accumulate("productClassName", this.getProductClassName());
		return jsonProductClass;
    }}