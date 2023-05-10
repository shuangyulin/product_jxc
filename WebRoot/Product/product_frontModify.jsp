<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.ProductClass" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的productClassObj信息
    List<ProductClass> productClassList = (List<ProductClass>)request.getAttribute("productClassList");
    Product product = (Product)request.getAttribute("product");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改商品信息信息</TITLE>
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
  		<li class="active">商品信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="productEditForm" id="productEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="product_productNo_edit" class="col-md-3 text-right">商品编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="product_productNo_edit" name="product.productNo" class="form-control" placeholder="请输入商品编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="product_productClassObj_productClassId_edit" class="col-md-3 text-right">商品类别:</label>
		  	 <div class="col-md-9">
			    <select id="product_productClassObj_productClassId_edit" name="product.productClassObj.productClassId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_productName_edit" class="col-md-3 text-right">商品名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="product_productName_edit" name="product.productName" class="form-control" placeholder="请输入商品名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_productPhoto_edit" class="col-md-3 text-right">产品图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="product_productPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="product_productPhoto" name="product.productPhoto"/>
			    <input id="productPhotoFile" name="productPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_count_edit" class="col-md-3 text-right">商品库存:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="product_count_edit" name="product.count" class="form-control" placeholder="请输入商品库存">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_price_edit" class="col-md-3 text-right">市场价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="product_price_edit" name="product.price" class="form-control" placeholder="请输入市场价">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_madeAddress_edit" class="col-md-3 text-right">产地:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="product_madeAddress_edit" name="product.madeAddress" class="form-control" placeholder="请输入产地">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_guige_edit" class="col-md-3 text-right">规格:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="product_guige_edit" name="product.guige" class="form-control" placeholder="请输入规格">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_madeDate_edit" class="col-md-3 text-right">生产日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date product_madeDate_edit col-md-12" data-link-field="product_madeDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="product_madeDate_edit" name="product.madeDate" size="16" type="text" value="" placeholder="请选择生产日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_yxq_edit" class="col-md-3 text-right">有效期:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="product_yxq_edit" name="product.yxq" class="form-control" placeholder="请输入有效期">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_beizhu_edit" class="col-md-3 text-right">备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="product_beizhu_edit" name="product.beizhu" rows="8" class="form-control" placeholder="请输入备注"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxProductModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#productEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改商品信息界面并初始化数据*/
function productEdit(productNo) {
	$.ajax({
		url :  basePath + "Product/" + productNo + "/update",
		type : "get",
		dataType: "json",
		success : function (product, response, status) {
			if (product) {
				$("#product_productNo_edit").val(product.productNo);
				$.ajax({
					url: basePath + "ProductClass/listAll",
					type: "get",
					success: function(productClasss,response,status) { 
						$("#product_productClassObj_productClassId_edit").empty();
						var html="";
		        		$(productClasss).each(function(i,productClass){
		        			html += "<option value='" + productClass.productClassId + "'>" + productClass.productClassName + "</option>";
		        		});
		        		$("#product_productClassObj_productClassId_edit").html(html);
		        		$("#product_productClassObj_productClassId_edit").val(product.productClassObjPri);
					}
				});
				$("#product_productName_edit").val(product.productName);
				$("#product_productPhoto").val(product.productPhoto);
				$("#product_productPhotoImg").attr("src", basePath +　product.productPhoto);
				$("#product_count_edit").val(product.count);
				$("#product_price_edit").val(product.price);
				$("#product_madeAddress_edit").val(product.madeAddress);
				$("#product_guige_edit").val(product.guige);
				$("#product_madeDate_edit").val(product.madeDate);
				$("#product_yxq_edit").val(product.yxq);
				$("#product_beizhu_edit").val(product.beizhu);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交商品信息信息表单给服务器端修改*/
function ajaxProductModify() {
	$.ajax({
		url :  basePath + "Product/" + $("#product_productNo_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#productEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#productQueryForm").submit();
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
    /*生产日期组件*/
    $('.product_madeDate_edit').datetimepicker({
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
    productEdit("<%=request.getParameter("productNo")%>");
 })
 </script> 
</body>
</html>

