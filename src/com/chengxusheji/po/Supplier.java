package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Supplier {
    /*供应商id*/
    private Integer supplierId;
    public Integer getSupplierId(){
        return supplierId;
    }
    public void setSupplierId(Integer supplierId){
        this.supplierId = supplierId;
    }

    /*供应商名称*/
    @NotEmpty(message="供应商名称不能为空")
    private String supplierName;
    public String getSupplierName() {
        return supplierName;
    }
    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    /*联系人*/
    @NotEmpty(message="联系人不能为空")
    private String personName;
    public String getPersonName() {
        return personName;
    }
    public void setPersonName(String personName) {
        this.personName = personName;
    }

    /*联系电话*/
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*地址*/
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSupplier=new JSONObject(); 
		jsonSupplier.accumulate("supplierId", this.getSupplierId());
		jsonSupplier.accumulate("supplierName", this.getSupplierName());
		jsonSupplier.accumulate("personName", this.getPersonName());
		jsonSupplier.accumulate("telephone", this.getTelephone());
		jsonSupplier.accumulate("address", this.getAddress());
		return jsonSupplier;
    }}