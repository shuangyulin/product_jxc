<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ProductClass" %>
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
<title>商品信息添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Product/frontlist">商品信息管理</a></li>
  			<li class="active">添加商品信息</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="productAddForm" id="productAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="product_productNo" class="col-md-2 text-right">商品编号:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="product_productNo" name="product.productNo" class="form-control" placeholder="请输入商品编号">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="product_productClassObj_productClassId" class="col-md-2 text-right">商品类别:</label>
				  	 <div class="col-md-8">
					    <select id="product_productClassObj_productClassId" name="product.productClassObj.productClassId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_productName" class="col-md-2 text-right">商品名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="product_productName" name="product.productName" class="form-control" placeholder="请输入商品名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_productPhoto" class="col-md-2 text-right">产品图片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="product_productPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="product_productPhoto" name="product.productPhoto"/>
					    <input id="productPhotoFile" name="productPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_count" class="col-md-2 text-right">商品库存:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="product_count" name="product.count" class="form-control" placeholder="请输入商品库存">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_price" class="col-md-2 text-right">市场价:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="product_price" name="product.price" class="form-control" placeholder="请输入市场价">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_madeAddress" class="col-md-2 text-right">产地:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="product_madeAddress" name="product.madeAddress" class="form-control" placeholder="请输入产地">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_guige" class="col-md-2 text-right">规格:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="product_guige" name="product.guige" class="form-control" placeholder="请输入规格">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_madeDateDiv" class="col-md-2 text-right">生产日期:</label>
				  	 <div class="col-md-8">
		                <div id="product_madeDateDiv" class="input-group date product_madeDate col-md-12" data-link-field="product_madeDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="product_madeDate" name="product.madeDate" size="16" type="text" value="" placeholder="请选择生产日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_yxq" class="col-md-2 text-right">有效期:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="product_yxq" name="product.yxq" class="form-control" placeholder="请输入有效期">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="product_beizhu" class="col-md-2 text-right">备注:</label>
				  	 <div class="col-md-8">
					    <textarea id="product_beizhu" name="product.beizhu" rows="8" class="form-control" placeholder="请输入备注"></textarea>
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxProductAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#productAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
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
	//提交添加商品信息信息
	function ajaxProductAdd() { 
		//提交之前先验证表单
		$("#productAddForm").data('bootstrapValidator').validate();
		if(!$("#productAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Product/add",
			dataType : "json" , 
			data: new FormData($("#productAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#productAddForm").find("input").val("");
					$("#productAddForm").find("textarea").val("");
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
	//验证商品信息添加表单字段
	$('#productAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"product.productNo": {
				validators: {
					notEmpty: {
						message: "商品编号不能为空",
					}
				}
			},
			"product.productName": {
				validators: {
					notEmpty: {
						message: "商品名称不能为空",
					}
				}
			},
			"product.count": {
				validators: {
					notEmpty: {
						message: "商品库存不能为空",
					},
					integer: {
						message: "商品库存不正确"
					}
				}
			},
			"product.price": {
				validators: {
					notEmpty: {
						message: "市场价不能为空",
					},
					numeric: {
						message: "市场价不正确"
					}
				}
			},
			"product.madeDate": {
				validators: {
					notEmpty: {
						message: "生产日期不能为空",
					}
				}
			},
		}
	}); 
	//初始化商品类别下拉框值 
	$.ajax({
		url: basePath + "ProductClass/listAll",
		type: "get",
		success: function(productClasss,response,status) { 
			$("#product_productClassObj_productClassId").empty();
			var html="";
    		$(productClasss).each(function(i,productClass){
    			html += "<option value='" + productClass.productClassId + "'>" + productClass.productClassName + "</option>";
    		});
    		$("#product_productClassObj_productClassId").html(html);
    	}
	});
	//生产日期组件
	$('#product_madeDateDiv').datetimepicker({
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
		$('#productAddForm').data('bootstrapValidator').updateStatus('product.madeDate', 'NOT_VALIDATED',null).validateField('product.madeDate');
	});
})
</script>
</body>
</html>
