<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>供应商添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Supplier/frontlist">供应商列表</a></li>
			    	<li role="presentation" class="active"><a href="#supplierAdd" aria-controls="supplierAdd" role="tab" data-toggle="tab">添加供应商</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="supplierList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="supplierAdd"> 
				      	<form class="form-horizontal" name="supplierAddForm" id="supplierAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="supplier_supplierName" class="col-md-2 text-right">供应商名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="supplier_supplierName" name="supplier.supplierName" class="form-control" placeholder="请输入供应商名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="supplier_personName" class="col-md-2 text-right">联系人:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="supplier_personName" name="supplier.personName" class="form-control" placeholder="请输入联系人">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="supplier_telephone" class="col-md-2 text-right">联系电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="supplier_telephone" name="supplier.telephone" class="form-control" placeholder="请输入联系电话">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="supplier_address" class="col-md-2 text-right">地址:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="supplier_address" name="supplier.address" class="form-control" placeholder="请输入地址">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxSupplierAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#supplierAddForm .form-group {margin:10px;}  </style>
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
	//提交添加供应商信息
	function ajaxSupplierAdd() { 
		//提交之前先验证表单
		$("#supplierAddForm").data('bootstrapValidator').validate();
		if(!$("#supplierAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Supplier/add",
			dataType : "json" , 
			data: new FormData($("#supplierAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#supplierAddForm").find("input").val("");
					$("#supplierAddForm").find("textarea").val("");
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
	//验证供应商添加表单字段
	$('#supplierAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"supplier.supplierName": {
				validators: {
					notEmpty: {
						message: "供应商名称不能为空",
					}
				}
			},
			"supplier.personName": {
				validators: {
					notEmpty: {
						message: "联系人不能为空",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
