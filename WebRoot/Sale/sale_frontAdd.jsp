<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Employee" %>
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
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
<title>销售信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Sale/frontlist">销售信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#saleAdd" aria-controls="saleAdd" role="tab" data-toggle="tab">添加销售信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="saleList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="saleAdd"> 
				      	<form class="form-horizontal" name="saleAddForm" id="saleAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="sale_productObj_productNo" class="col-md-2 text-right">销售商品:</label>
						  	 <div class="col-md-8">
							    <select id="sale_productObj_productNo" name="sale.productObj.productNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="sale_userObj_user_name" class="col-md-2 text-right">销售客户:</label>
						  	 <div class="col-md-8">
							    <select id="sale_userObj_user_name" name="sale.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="sale_price" class="col-md-2 text-right">销售单价:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="sale_price" name="sale.price" class="form-control" placeholder="请输入销售单价">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="sale_count" class="col-md-2 text-right">销售数量:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="sale_count" name="sale.count" class="form-control" placeholder="请输入销售数量">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="sale_saleDateDiv" class="col-md-2 text-right">销售日期:</label>
						  	 <div class="col-md-8">
				                <div id="sale_saleDateDiv" class="input-group date sale_saleDate col-md-12" data-link-field="sale_saleDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="sale_saleDate" name="sale.saleDate" size="16" type="text" value="" placeholder="请选择销售日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="sale_employeeObj_employeeNo" class="col-md-2 text-right">销售员工:</label>
						  	 <div class="col-md-8">
							    <select id="sale_employeeObj_employeeNo" name="sale.employeeObj.employeeNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="sale_memo" class="col-md-2 text-right">备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="sale_memo" name="sale.memo" rows="8" class="form-control" placeholder="请输入备注"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxSaleAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#saleAddForm .form-group {margin:10px;}  </style>
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
	//提交添加销售信息信息
	function ajaxSaleAdd() { 
		//提交之前先验证表单
		$("#saleAddForm").data('bootstrapValidator').validate();
		if(!$("#saleAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Sale/add",
			dataType : "json" , 
			data: new FormData($("#saleAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#saleAddForm").find("input").val("");
					$("#saleAddForm").find("textarea").val("");
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
	//验证销售信息添加表单字段
	$('#saleAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"sale.price": {
				validators: {
					notEmpty: {
						message: "销售单价不能为空",
					},
					numeric: {
						message: "销售单价不正确"
					}
				}
			},
			"sale.count": {
				validators: {
					notEmpty: {
						message: "销售数量不能为空",
					},
					integer: {
						message: "销售数量不正确"
					}
				}
			},
			"sale.saleDate": {
				validators: {
					notEmpty: {
						message: "销售日期不能为空",
					}
				}
			},
		}
	}); 
	//初始化销售商品下拉框值 
	$.ajax({
		url: basePath + "Product/listAll",
		type: "get",
		success: function(products,response,status) { 
			$("#sale_productObj_productNo").empty();
			var html="";
    		$(products).each(function(i,product){
    			html += "<option value='" + product.productNo + "'>" + product.productName + "</option>";
    		});
    		$("#sale_productObj_productNo").html(html);
    	}
	});
	//初始化销售客户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#sale_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#sale_userObj_user_name").html(html);
    	}
	});
	//初始化销售员工下拉框值 
	$.ajax({
		url: basePath + "Employee/listAll",
		type: "get",
		success: function(employees,response,status) { 
			$("#sale_employeeObj_employeeNo").empty();
			var html="";
    		$(employees).each(function(i,employee){
    			html += "<option value='" + employee.employeeNo + "'>" + employee.name + "</option>";
    		});
    		$("#sale_employeeObj_employeeNo").html(html);
    	}
	});
	//销售日期组件
	$('#sale_saleDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#saleAddForm').data('bootstrapValidator').updateStatus('sale.saleDate', 'NOT_VALIDATED',null).validateField('sale.saleDate');
	});
})
</script>
</body>
</html>
