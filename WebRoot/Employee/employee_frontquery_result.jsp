<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Employee" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Employee> employeeList = (List<Employee>)request.getAttribute("employeeList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String employeeNo = (String)request.getAttribute("employeeNo"); //员工编号查询关键字
    String name = (String)request.getAttribute("name"); //姓名查询关键字
    String department = (String)request.getAttribute("department"); //所在部门查询关键字
    String birthDate = (String)request.getAttribute("birthDate"); //出生日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>员工信息查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Employee/frontlist">员工信息信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Employee/employee_frontAdd.jsp" style="display:none;">添加员工信息</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<employeeList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Employee employee = employeeList.get(i); //获取到员工信息对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Employee/<%=employee.getEmployeeNo() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=employee.getPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		员工编号:<%=employee.getEmployeeNo() %>
			     	</div>
			     	<div class="field">
	            		姓名:<%=employee.getName() %>
			     	</div>
			     	<div class="field">
	            		性别:<%=employee.getSex() %>
			     	</div>
			     	<div class="field">
	            		所在部门:<%=employee.getDepartment() %>
			     	</div>
			     	<div class="field">
	            		出生日期:<%=employee.getBirthDate() %>
			     	</div>
			     	<div class="field">
	            		联系电话:<%=employee.getTelephone() %>
			     	</div>
			     	<div class="field">
	            		联系地址:<%=employee.getAddress() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Employee/<%=employee.getEmployeeNo() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="employeeEdit('<%=employee.getEmployeeNo() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="employeeDelete('<%=employee.getEmployeeNo() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>员工信息查询</h1>
		</div>
		<form name="employeeQueryForm" id="employeeQueryForm" action="<%=basePath %>Employee/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="employeeNo">员工编号:</label>
				<input type="text" id="employeeNo" name="employeeNo" value="<%=employeeNo %>" class="form-control" placeholder="请输入员工编号">
			</div>
			<div class="form-group">
				<label for="name">姓名:</label>
				<input type="text" id="name" name="name" value="<%=name %>" class="form-control" placeholder="请输入姓名">
			</div>
			<div class="form-group">
				<label for="department">所在部门:</label>
				<input type="text" id="department" name="department" value="<%=department %>" class="form-control" placeholder="请输入所在部门">
			</div>
			<div class="form-group">
				<label for="birthDate">出生日期:</label>
				<input type="text" id="birthDate" name="birthDate" class="form-control"  placeholder="请选择出生日期" value="<%=birthDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="employeeEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;员工信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#employeeEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxEmployeeModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.employeeQueryForm.currentPage.value = currentPage;
    document.employeeQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.employeeQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.employeeQueryForm.currentPage.value = pageValue;
    documentemployeeQueryForm.submit();
}

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
				$('#employeeEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除员工信息信息*/
function employeeDelete(employeeNo) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Employee/deletes",
			data : {
				employeeNos : employeeNo,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#employeeQueryForm").submit();
					//location.href= basePath + "Employee/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

