<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Employee" %>
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.Supplier" %>
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
<title>进货信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Purchase/frontlist">进货信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#purchaseAdd" aria-controls="purchaseAdd" role="tab" data-toggle="tab">添加进货信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="purchaseList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="purchaseAdd"> 
				      	<form class="form-horizontal" name="purchaseAddForm" id="purchaseAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="purchase_productObj_productNo" class="col-md-2 text-right">进货商品:</label>
						  	 <div class="col-md-8">
							    <select id="purchase_productObj_productNo" name="purchase.productObj.productNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="purchase_supplierObj_supplierId" class="col-md-2 text-right">供应商:</label>
						  	 <div class="col-md-8">
							    <select id="purchase_supplierObj_supplierId" name="purchase.supplierObj.supplierId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="purchase_price" class="col-md-2 text-right">进货单价:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="purchase_price" name="purchase.price" class="form-control" placeholder="请输入进货单价">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="purchase_count" class="col-md-2 text-right">进货数量:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="purchase_count" name="purchase.count" class="form-control" placeholder="请输入进货数量">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="purchase_purchaseDateDiv" class="col-md-2 text-right">进货日期:</label>
						  	 <div class="col-md-8">
				                <div id="purchase_purchaseDateDiv" class="input-group date purchase_purchaseDate col-md-12" data-link-field="purchase_purchaseDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="purchase_purchaseDate" name="purchase.purchaseDate" size="16" type="text" value="" placeholder="请选择进货日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="purchase_employeeObj_employeeNo" class="col-md-2 text-right">进货员工:</label>
						  	 <div class="col-md-8">
							    <select id="purchase_employeeObj_employeeNo" name="purchase.employeeObj.employeeNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="purchase_memo" class="col-md-2 text-right">备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="purchase_memo" name="purchase.memo" rows="8" class="form-control" placeholder="请输入备注"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxPurchaseAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#purchaseAddForm .form-group {margin:10px;}  </style>
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
	//提交添加进货信息信息
	function ajaxPurchaseAdd() { 
		//提交之前先验证表单
		$("#purchaseAddForm").data('bootstrapValidator').validate();
		if(!$("#purchaseAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Purchase/add",
			dataType : "json" , 
			data: new FormData($("#purchaseAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#purchaseAddForm").find("input").val("");
					$("#purchaseAddForm").find("textarea").val("");
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
	//验证进货信息添加表单字段
	$('#purchaseAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"purchase.price": {
				validators: {
					notEmpty: {
						message: "进货单价不能为空",
					},
					numeric: {
						message: "进货单价不正确"
					}
				}
			},
			"purchase.count": {
				validators: {
					notEmpty: {
						message: "进货数量不能为空",
					},
					integer: {
						message: "进货数量不正确"
					}
				}
			},
			"purchase.purchaseDate": {
				validators: {
					notEmpty: {
						message: "进货日期不能为空",
					}
				}
			},
		}
	}); 
	//初始化进货商品下拉框值 
	$.ajax({
		url: basePath + "Product/listAll",
		type: "get",
		success: function(products,response,status) { 
			$("#purchase_productObj_productNo").empty();
			var html="";
    		$(products).each(function(i,product){
    			html += "<option value='" + product.productNo + "'>" + product.productName + "</option>";
    		});
    		$("#purchase_productObj_productNo").html(html);
    	}
	});
	//初始化供应商下拉框值 
	$.ajax({
		url: basePath + "Supplier/listAll",
		type: "get",
		success: function(suppliers,response,status) { 
			$("#purchase_supplierObj_supplierId").empty();
			var html="";
    		$(suppliers).each(function(i,supplier){
    			html += "<option value='" + supplier.supplierId + "'>" + supplier.supplierName + "</option>";
    		});
    		$("#purchase_supplierObj_supplierId").html(html);
    	}
	});
	//初始化进货员工下拉框值 
	$.ajax({
		url: basePath + "Employee/listAll",
		type: "get",
		success: function(employees,response,status) { 
			$("#purchase_employeeObj_employeeNo").empty();
			var html="";
    		$(employees).each(function(i,employee){
    			html += "<option value='" + employee.employeeNo + "'>" + employee.name + "</option>";
    		});
    		$("#purchase_employeeObj_employeeNo").html(html);
    	}
	});
	//进货日期组件
	$('#purchase_purchaseDateDiv').datetimepicker({
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
		$('#purchaseAddForm').data('bootstrapValidator').updateStatus('purchase.purchaseDate', 'NOT_VALIDATED',null).validateField('purchase.purchaseDate');
	});
})
</script>
</body>
</html>
