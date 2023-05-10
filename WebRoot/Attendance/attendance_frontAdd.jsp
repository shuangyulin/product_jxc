<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Employee" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>员工出勤添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Attendance/frontlist">员工出勤列表</a></li>
			    	<li role="presentation" class="active"><a href="#attendanceAdd" aria-controls="attendanceAdd" role="tab" data-toggle="tab">添加员工出勤</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="attendanceList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="attendanceAdd"> 
				      	<form class="form-horizontal" name="attendanceAddForm" id="attendanceAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="attendance_employeeObj_employeeNo" class="col-md-2 text-right">员工:</label>
						  	 <div class="col-md-8">
							    <select id="attendance_employeeObj_employeeNo" name="attendance.employeeObj.employeeNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="attendance_year" class="col-md-2 text-right">年份:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="attendance_year" name="attendance.year" class="form-control" placeholder="请输入年份">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="attendance_month" class="col-md-2 text-right">月份:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="attendance_month" name="attendance.month" class="form-control" placeholder="请输入月份">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="attendance_shouldComeDays" class="col-md-2 text-right">应到天数:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="attendance_shouldComeDays" name="attendance.shouldComeDays" class="form-control" placeholder="请输入应到天数">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="attendance_leaveDays" class="col-md-2 text-right">请假天数:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="attendance_leaveDays" name="attendance.leaveDays" class="form-control" placeholder="请输入请假天数">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="attendance_absenceDays" class="col-md-2 text-right">缺勤天数:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="attendance_absenceDays" name="attendance.absenceDays" class="form-control" placeholder="请输入缺勤天数">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxAttendanceAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#attendanceAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加员工出勤信息
	function ajaxAttendanceAdd() { 
		//提交之前先验证表单
		$("#attendanceAddForm").data('bootstrapValidator').validate();
		if(!$("#attendanceAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Attendance/add",
			dataType : "json" , 
			data: new FormData($("#attendanceAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#attendanceAddForm").find("input").val("");
					$("#attendanceAddForm").find("textarea").val("");
				} else {
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
	//验证员工出勤添加表单字段
	$('#attendanceAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"attendance.year": {
				validators: {
					notEmpty: {
						message: "年份不能为空",
					}
				}
			},
			"attendance.month": {
				validators: {
					notEmpty: {
						message: "月份不能为空",
					}
				}
			},
			"attendance.shouldComeDays": {
				validators: {
					notEmpty: {
						message: "应到天数不能为空",
					},
					numeric: {
						message: "应到天数不正确"
					}
				}
			},
			"attendance.leaveDays": {
				validators: {
					notEmpty: {
						message: "请假天数不能为空",
					},
					numeric: {
						message: "请假天数不正确"
					}
				}
			},
			"attendance.absenceDays": {
				validators: {
					notEmpty: {
						message: "缺勤天数不能为空",
					},
					numeric: {
						message: "缺勤天数不正确"
					}
				}
			},
		}
	}); 
	//初始化员工下拉框值 
	$.ajax({
		url: basePath + "Employee/listAll",
		type: "get",
		success: function(employees,response,status) { 
			$("#attendance_employeeObj_employeeNo").empty();
			var html="";
    		$(employees).each(function(i,employee){
    			html += "<option value='" + employee.employeeNo + "'>" + employee.name + "</option>";
    		});
    		$("#attendance_employeeObj_employeeNo").html(html);
    	}
	});
})
</script>
</body>
</html>
