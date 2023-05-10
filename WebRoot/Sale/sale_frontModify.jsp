<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Sale" %>
<%@ page import="com.chengxusheji.po.Employee" %>
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的employeeObj信息
    List<Employee> employeeList = (List<Employee>)request.getAttribute("employeeList");
    //获取所有的productObj信息
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Sale sale = (Sale)request.getAttribute("sale");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改销售信息信息</TITLE>
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
  		<li class="active">销售信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="saleEditForm" id="saleEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="sale_saleId_edit" class="col-md-3 text-right">销售id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="sale_saleId_edit" name="sale.saleId" class="form-control" placeholder="请输入销售id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="sale_productObj_productNo_edit" class="col-md-3 text-right">销售商品:</label>
		  	 <div class="col-md-9">
			    <select id="sale_productObj_productNo_edit" name="sale.productObj.productNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="sale_userObj_user_name_edit" class="col-md-3 text-right">销售客户:</label>
		  	 <div class="col-md-9">
			    <select id="sale_userObj_user_name_edit" name="sale.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="sale_price_edit" class="col-md-3 text-right">销售单价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="sale_price_edit" name="sale.price" class="form-control" placeholder="请输入销售单价">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="sale_count_edit" class="col-md-3 text-right">销售数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="sale_count_edit" name="sale.count" class="form-control" placeholder="请输入销售数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="sale_saleDate_edit" class="col-md-3 text-right">销售日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date sale_saleDate_edit col-md-12" data-link-field="sale_saleDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="sale_saleDate_edit" name="sale.saleDate" size="16" type="text" value="" placeholder="请选择销售日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="sale_employeeObj_employeeNo_edit" class="col-md-3 text-right">销售员工:</label>
		  	 <div class="col-md-9">
			    <select id="sale_employeeObj_employeeNo_edit" name="sale.employeeObj.employeeNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="sale_memo_edit" class="col-md-3 text-right">备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="sale_memo_edit" name="sale.memo" rows="8" class="form-control" placeholder="请输入备注"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxSaleModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#saleEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改销售信息界面并初始化数据*/
function saleEdit(saleId) {
	$.ajax({
		url :  basePath + "Sale/" + saleId + "/update",
		type : "get",
		dataType: "json",
		success : function (sale, response, status) {
			if (sale) {
				$("#sale_saleId_edit").val(sale.saleId);
				$.ajax({
					url: basePath + "Product/listAll",
					type: "get",
					success: function(products,response,status) { 
						$("#sale_productObj_productNo_edit").empty();
						var html="";
		        		$(products).each(function(i,product){
		        			html += "<option value='" + product.productNo + "'>" + product.productName + "</option>";
		        		});
		        		$("#sale_productObj_productNo_edit").html(html);
		        		$("#sale_productObj_productNo_edit").val(sale.productObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#sale_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#sale_userObj_user_name_edit").html(html);
		        		$("#sale_userObj_user_name_edit").val(sale.userObjPri);
					}
				});
				$("#sale_price_edit").val(sale.price);
				$("#sale_count_edit").val(sale.count);
				$("#sale_saleDate_edit").val(sale.saleDate);
				$.ajax({
					url: basePath + "Employee/listAll",
					type: "get",
					success: function(employees,response,status) { 
						$("#sale_employeeObj_employeeNo_edit").empty();
						var html="";
		        		$(employees).each(function(i,employee){
		        			html += "<option value='" + employee.employeeNo + "'>" + employee.name + "</option>";
		        		});
		        		$("#sale_employeeObj_employeeNo_edit").html(html);
		        		$("#sale_employeeObj_employeeNo_edit").val(sale.employeeObjPri);
					}
				});
				$("#sale_memo_edit").val(sale.memo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交销售信息信息表单给服务器端修改*/
function ajaxSaleModify() {
	$.ajax({
		url :  basePath + "Sale/" + $("#sale_saleId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#saleEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#saleQueryForm").submit();
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
    /*销售日期组件*/
    $('.sale_saleDate_edit').datetimepicker({
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
    saleEdit("<%=request.getParameter("saleId")%>");
 })
 </script> 
</body>
</html>

