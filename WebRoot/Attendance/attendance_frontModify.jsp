<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Attendance" %>
<%@ page import="com.chengxusheji.po.Employee" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的employeeObj信息
    List<Employee> employeeList = (List<Employee>)request.getAttribute("employeeList");
    Attendance attendance = (Attendance)request.getAttribute("attendance");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改员工出勤信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">员工出勤信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="attendanceEditForm" id="attendanceEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="attendance_attendanceId_edit" class="col-md-3 text-right">出勤id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="attendance_attendanceId_edit" name="attendance.attendanceId" class="form-control" placeholder="请输入出勤id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="attendance_employeeObj_employeeNo_edit" class="col-md-3 text-right">员工:</label>
		  	 <div class="col-md-9">
			    <select id="attendance_employeeObj_employeeNo_edit" name="attendance.employeeObj.employeeNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="attendance_year_edit" class="col-md-3 text-right">年份:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="attendance_year_edit" name="attendance.year" class="form-control" placeholder="请输入年份">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="attendance_month_edit" class="col-md-3 text-right">月份:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="attendance_month_edit" name="attendance.month" class="form-control" placeholder="请输入月份">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="attendance_shouldComeDays_edit" class="col-md-3 text-right">应到天数:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="attendance_shouldComeDays_edit" name="attendance.shouldComeDays" class="form-control" placeholder="请输入应到天数">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="attendance_leaveDays_edit" class="col-md-3 text-right">请假天数:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="attendance_leaveDays_edit" name="attendance.leaveDays" class="form-control" placeholder="请输入请假天数">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="attendance_absenceDays_edit" class="col-md-3 text-right">缺勤天数:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="attendance_absenceDays_edit" name="attendance.absenceDays" class="form-control" placeholder="请输入缺勤天数">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxAttendanceModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#attendanceEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改员工出勤界面并初始化数据*/
function attendanceEdit(attendanceId) {
	$.ajax({
		url :  basePath + "Attendance/" + attendanceId + "/update",
		type : "get",
		dataType: "json",
		success : function (attendance, response, status) {
			if (attendance) {
				$("#attendance_attendanceId_edit").val(attendance.attendanceId);
				$.ajax({
					url: basePath + "Employee/listAll",
					type: "get",
					success: function(employees,response,status) { 
						$("#attendance_employeeObj_employeeNo_edit").empty();
						var html="";
		        		$(employees).each(function(i,employee){
		        			html += "<option value='" + employee.employeeNo + "'>" + employee.name + "</option>";
		        		});
		        		$("#attendance_employeeObj_employeeNo_edit").html(html);
		        		$("#attendance_employeeObj_employeeNo_edit").val(attendance.employeeObjPri);
					}
				});
				$("#attendance_year_edit").val(attendance.year);
				$("#attendance_month_edit").val(attendance.month);
				$("#attendance_shouldComeDays_edit").val(attendance.shouldComeDays);
				$("#attendance_leaveDays_edit").val(attendance.leaveDays);
				$("#attendance_absenceDays_edit").val(attendance.absenceDays);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交员工出勤信息表单给服务器端修改*/
function ajaxAttendanceModify() {
	$.ajax({
		url :  basePath + "Attendance/" + $("#attendance_attendanceId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#attendanceEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#attendanceQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    attendanceEdit("<%=request.getParameter("attendanceId")%>");
 })
 </script> 
</body>
</html>

