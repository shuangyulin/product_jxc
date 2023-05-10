package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Attendance {
    /*出勤id*/
    private Integer attendanceId;
    public Integer getAttendanceId(){
        return attendanceId;
    }
    public void setAttendanceId(Integer attendanceId){
        this.attendanceId = attendanceId;
    }

    /*员工*/
    private Employee employeeObj;
    public Employee getEmployeeObj() {
        return employeeObj;
    }
    public void setEmployeeObj(Employee employeeObj) {
        this.employeeObj = employeeObj;
    }

    /*年份*/
    @NotEmpty(message="年份不能为空")
    private String year;
    public String getYear() {
        return year;
    }
    public void setYear(String year) {
        this.year = year;
    }

    /*月份*/
    @NotEmpty(message="月份不能为空")
    private String month;
    public String getMonth() {
        return month;
    }
    public void setMonth(String month) {
        this.month = month;
    }

    /*应到天数*/
    @NotNull(message="必须输入应到天数")
    private Float shouldComeDays;
    public Float getShouldComeDays() {
        return shouldComeDays;
    }
    public void setShouldComeDays(Float shouldComeDays) {
        this.shouldComeDays = shouldComeDays;
    }

    /*请假天数*/
    @NotNull(message="必须输入请假天数")
    private Float leaveDays;
    public Float getLeaveDays() {
        return leaveDays;
    }
    public void setLeaveDays(Float leaveDays) {
        this.leaveDays = leaveDays;
    }

    /*缺勤天数*/
    @NotNull(message="必须输入缺勤天数")
    private Float absenceDays;
    public Float getAbsenceDays() {
        return absenceDays;
    }
    public void setAbsenceDays(Float absenceDays) {
        this.absenceDays = absenceDays;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonAttendance=new JSONObject(); 
		jsonAttendance.accumulate("attendanceId", this.getAttendanceId());
		jsonAttendance.accumulate("employeeObj", this.getEmployeeObj().getName());
		jsonAttendance.accumulate("employeeObjPri", this.getEmployeeObj().getEmployeeNo());
		jsonAttendance.accumulate("year", this.getYear());
		jsonAttendance.accumulate("month", this.getMonth());
		jsonAttendance.accumulate("shouldComeDays", this.getShouldComeDays());
		jsonAttendance.accumulate("leaveDays", this.getLeaveDays());
		jsonAttendance.accumulate("absenceDays", this.getAbsenceDays());
		return jsonAttendance;
    }}