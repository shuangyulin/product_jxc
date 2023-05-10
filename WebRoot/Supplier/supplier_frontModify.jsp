<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Supplier" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Supplier supplier = (Supplier)request.getAttribute("supplier");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改供应商信息</TITLE>
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
  		<li class="active">供应商信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="supplierEditForm" id="supplierEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="supplier_supplierId_edit" class="col-md-3 text-right">供应商id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="supplier_supplierId_edit" name="supplier.supplierId" class="form-control" placeholder="请输入供应商id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="supplier_supplierName_edit" class="col-md-3 text-right">供应商名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="supplier_supplierName_edit" name="supplier.supplierName" class="form-control" placeholder="请输入供应商名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="supplier_personName_edit" class="col-md-3 text-right">联系人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="supplier_personName_edit" name="supplier.personName" class="form-control" placeholder="请输入联系人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="supplier_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="supplier_telephone_edit" name="supplier.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="supplier_address_edit" class="col-md-3 text-right">地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="supplier_address_edit" name="supplier.address" class="form-control" placeholder="请输入地址">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxSupplierModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#supplierEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改供应商界面并初始化数据*/
function supplierEdit(supplierId) {
	$.ajax({
		url :  basePath + "Supplier/" + supplierId + "/update",
		type : "get",
		dataType: "json",
		success : function (supplier, response, status) {
			if (supplier) {
				$("#supplier_supplierId_edit").val(supplier.supplierId);
				$("#supplier_supplierName_edit").val(supplier.supplierName);
				$("#supplier_personName_edit").val(supplier.personName);
				$("#supplier_telephone_edit").val(supplier.telephone);
				$("#supplier_address_edit").val(supplier.address);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交供应商信息表单给服务器端修改*/
function ajaxSupplierModify() {
	$.ajax({
		url :  basePath + "Supplier/" + $("#supplier_supplierId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#supplierEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#supplierQueryForm").submit();
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
    supplierEdit("<%=request.getParameter("supplierId")%>");
 })
 </script> 
</body>
</html>

