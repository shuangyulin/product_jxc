<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Employee" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Employee employee = (Employee)request.getAttribute("employee");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改员工信息信息</TITLE>
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
  		<li class="active">员工信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="employeeEditForm" id="employeeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="employee_employeeNo_edit" class="col-md-3 text-right">员工编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="employee_employeeNo_edit" name="employee.employeeNo" class="form-control" placeholder="请输入员工编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="employee_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="employee_password_edit" name="employee.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_name_edit" class="col-md-3 text-right">姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="employee_name_edit" name="employee.name" class="form-control" placeholder="请输入姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_sex_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="employee_sex_edit" name="employee.sex" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_photo_edit" class="col-md-3 text-right">员工照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="employee_photoImg" border="0px"/><br/>
			    <input type="hidden" id="employee_photo" name="employee.photo"/>
			    <input id="photoFile" name="photoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_department_edit" class="col-md-3 text-right">所在部门:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="employee_department_edit" name="employee.department" class="form-control" placeholder="请输入所在部门">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_birthDate_edit" class="col-md-3 text-right">出生日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date employee_birthDate_edit col-md-12" data-link-field="employee_birthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="employee_birthDate_edit" name="employee.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="employee_telephone_edit" name="employee.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_address_edit" class="col-md-3 text-right">联系地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="employee_address_edit" name="employee.address" class="form-control" placeholder="请输入联系地址">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxEmployeeModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#employeeEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改员工信息界面并初始化数据*/
function employeeEdit(employeeNo) {
	$.ajax({
		url :  basePath + "Employee/" + employeeNo + "/update",
		type : "get",
		dataType: "json",
		success : function (employee, response, status) {
			if (employee) {
				$("#employee_employeeNo_edit").val(employee.employeeNo);
				$("#employee_password_edit").val(employee.password);
				$("#employee_name_edit").val(employee.name);
				$("#employee_sex_edit").val(employee.sex);
				$("#employee_photo").val(employee.photo);
				$("#employee_photoImg").attr("src", basePath +　employee.photo);
				$("#employee_department_edit").val(employee.department);
				$("#employee_birthDate_edit").val(employee.birthDate);
				$("#employee_telephone_edit").val(employee.telephone);
				$("#employee_address_edit").val(employee.address);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交员工信息信息表单给服务器端修改*/
function ajaxEmployeeModify() {
	$.ajax({
		url :  basePath + "Employee/" + $("#employee_employeeNo_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#employeeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#employeeQueryForm").submit();
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
    /*出生日期组件*/
    $('.employee_birthDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    employeeEdit("<%=request.getParameter("employeeNo")%>");
 })
 </script> 
</body>
</html>

