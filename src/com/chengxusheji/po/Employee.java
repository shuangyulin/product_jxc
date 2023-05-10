package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Employee {
    /*员工编号*/
    @NotEmpty(message="员工编号不能为空")
    private String employeeNo;
    public String getEmployeeNo(){
        return employeeNo;
    }
    public void setEmployeeNo(String employeeNo){
        this.employeeNo = employeeNo;
    }

    /*登录密码*/
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String sex;
    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }

    /*员工照片*/
    private String photo;
    public String getPhoto() {
        return photo;
    }
    public void setPhoto(String photo) {
        this.photo = photo;
    }

    /*所在部门*/
    @NotEmpty(message="所在部门不能为空")
    private String department;
    public String getDepartment() {
        return department;
    }
    public void setDepartment(String department) {
        this.department = department;
    }

    /*出生日期*/
    @NotEmpty(message="出生日期不能为空")
    private String birthDate;
    public String getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    /*联系电话*/
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*联系地址*/
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonEmployee=new JSONObject(); 
		jsonEmployee.accumulate("employeeNo", this.getEmployeeNo());
		jsonEmployee.accumulate("password", this.getPassword());
		jsonEmployee.accumulate("name", this.getName());
		jsonEmployee.accumulate("sex", this.getSex());
		jsonEmployee.accumulate("photo", this.getPhoto());
		jsonEmployee.accumulate("department", this.getDepartment());
		jsonEmployee.accumulate("birthDate", this.getBirthDate().length()>19?this.getBirthDate().substring(0,19):this.getBirthDate());
		jsonEmployee.accumulate("telephone", this.getTelephone());
		jsonEmployee.accumulate("address", this.getAddress());
		return jsonEmployee;
    }}