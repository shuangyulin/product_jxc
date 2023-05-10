<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Purchase" %>
<%@ page import="com.chengxusheji.po.Employee" %>
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.Supplier" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的employeeObj信息
    List<Employee> employeeList = (List<Employee>)request.getAttribute("employeeList");
    //获取所有的productObj信息
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    //获取所有的supplierObj信息
    List<Supplier> supplierList = (List<Supplier>)request.getAttribute("supplierList");
    Purchase purchase = (Purchase)request.getAttribute("purchase");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改进货信息信息</TITLE>
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
  		<li class="active">进货信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="purchaseEditForm" id="purchaseEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="purchase_purchaseId_edit" class="col-md-3 text-right">进货id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="purchase_purchaseId_edit" name="purchase.purchaseId" class="form-control" placeholder="请输入进货id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="purchase_productObj_productNo_edit" class="col-md-3 text-right">进货商品:</label>
		  	 <div class="col-md-9">
			    <select id="purchase_productObj_productNo_edit" name="purchase.productObj.productNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_supplierObj_supplierId_edit" class="col-md-3 text-right">供应商:</label>
		  	 <div class="col-md-9">
			    <select id="purchase_supplierObj_supplierId_edit" name="purchase.supplierObj.supplierId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_price_edit" class="col-md-3 text-right">进货单价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="purchase_price_edit" name="purchase.price" class="form-control" placeholder="请输入进货单价">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_count_edit" class="col-md-3 text-right">进货数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="purchase_count_edit" name="purchase.count" class="form-control" placeholder="请输入进货数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_purchaseDate_edit" class="col-md-3 text-right">进货日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date purchase_purchaseDate_edit col-md-12" data-link-field="purchase_purchaseDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="purchase_purchaseDate_edit" name="purchase.purchaseDate" size="16" type="text" value="" placeholder="请选择进货日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_employeeObj_employeeNo_edit" class="col-md-3 text-right">进货员工:</label>
		  	 <div class="col-md-9">
			    <select id="purchase_employeeObj_employeeNo_edit" name="purchase.employeeObj.employeeNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_memo_edit" class="col-md-3 text-right">备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="purchase_memo_edit" name="purchase.memo" rows="8" class="form-control" placeholder="请输入备注"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxPurchaseModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#purchaseEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改进货信息界面并初始化数据*/
function purchaseEdit(purchaseId) {
	$.ajax({
		url :  basePath + "Purchase/" + purchaseId + "/update",
		type : "get",
		dataType: "json",
		success : function (purchase, response, status) {
			if (purchase) {
				$("#purchase_purchaseId_edit").val(purchase.purchaseId);
				$.ajax({
					url: basePath + "Product/listAll",
					type: "get",
					success: function(products,response,status) { 
						$("#purchase_productObj_productNo_edit").empty();
						var html="";
		        		$(products).each(function(i,product){
		        			html += "<option value='" + product.productNo + "'>" + product.productName + "</option>";
		        		});
		        		$("#purchase_productObj_productNo_edit").html(html);
		        		$("#purchase_productObj_productNo_edit").val(purchase.productObjPri);
					}
				});
				$.ajax({
					url: basePath + "Supplier/listAll",
					type: "get",
					success: function(suppliers,response,status) { 
						$("#purchase_supplierObj_supplierId_edit").empty();
						var html="";
		        		$(suppliers).each(function(i,supplier){
		        			html += "<option value='" + supplier.supplierId + "'>" + supplier.supplierName + "</option>";
		        		});
		        		$("#purchase_supplierObj_supplierId_edit").html(html);
		        		$("#purchase_supplierObj_supplierId_edit").val(purchase.supplierObjPri);
					}
				});
				$("#purchase_price_edit").val(purchase.price);
				$("#purchase_count_edit").val(purchase.count);
				$("#purchase_purchaseDate_edit").val(purchase.purchaseDate);
				$.ajax({
					url: basePath + "Employee/listAll",
					type: "get",
					success: function(employees,response,status) { 
						$("#purchase_employeeObj_employeeNo_edit").empty();
						var html="";
		        		$(employees).each(function(i,employee){
		        			html += "<option value='" + employee.employeeNo + "'>" + employee.name + "</option>";
		        		});
		        		$("#purchase_employeeObj_employeeNo_edit").html(html);
		        		$("#purchase_employeeObj_employeeNo_edit").val(purchase.employeeObjPri);
					}
				});
				$("#purchase_memo_edit").val(purchase.memo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交进货信息信息表单给服务器端修改*/
function ajaxPurchaseModify() {
	$.ajax({
		url :  basePath + "Purchase/" + $("#purchase_purchaseId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#purchaseEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#purchaseQueryForm").submit();
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
    /*进货日期组件*/
    $('.purchase_purchaseDate_edit').datetimepicker({
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
    purchaseEdit("<%=request.getParameter("purchaseId")%>");
 })
 </script> 
</body>
</html>

