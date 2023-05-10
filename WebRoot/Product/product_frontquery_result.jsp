<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.ProductClass" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    //获取所有的productClassObj信息
    List<ProductClass> productClassList = (List<ProductClass>)request.getAttribute("productClassList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String productNo = (String)request.getAttribute("productNo"); //商品编号查询关键字
    ProductClass productClassObj = (ProductClass)request.getAttribute("productClassObj");
    String productName = (String)request.getAttribute("productName"); //商品名称查询关键字
    String madeDate = (String)request.getAttribute("madeDate"); //生产日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>商品信息查询</title>
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
  			<li><a href="<%=basePath %>Product/frontlist">商品信息信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Product/product_frontAdd.jsp" style="display:none;">添加商品信息</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<productList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Product product = productList.get(i); //获取到商品信息对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Product/<%=product.getProductNo() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=product.getProductPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		商品编号:<%=product.getProductNo() %>
			     	</div>
			     	<div class="field">
	            		商品类别:<%=product.getProductClassObj().getProductClassName() %>
			     	</div>
			     	<div class="field">
	            		商品名称:<%=product.getProductName() %>
			     	</div>
			     	<div class="field">
	            		商品库存:<%=product.getCount() %>
			     	</div>
			     	<div class="field">
	            		市场价:<%=product.getPrice() %>
			     	</div>
			     	<div class="field">
	            		产地:<%=product.getMadeAddress() %>
			     	</div>
			     	<div class="field">
	            		规格:<%=product.getGuige() %>
			     	</div>
			     	<div class="field">
	            		生产日期:<%=product.getMadeDate() %>
			     	</div>
			     	<div class="field">
	            		有效期:<%=product.getYxq() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Product/<%=product.getProductNo() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="productEdit('<%=product.getProductNo() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="productDelete('<%=product.getProductNo() %>');" style="display:none;">删除</a>
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
    		<h1>商品信息查询</h1>
		</div>
		<form name="productQueryForm" id="productQueryForm" action="<%=basePath %>Product/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="productNo">商品编号:</label>
				<input type="text" id="productNo" name="productNo" value="<%=productNo %>" class="form-control" placeholder="请输入商品编号">
			</div>
            <div class="form-group">
            	<label for="productClassObj_productClassId">商品类别：</label>
                <select id="productClassObj_productClassId" name="productClassObj.productClassId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(ProductClass productClassTemp:productClassList) {
	 					String selected = "";
 					if(productClassObj!=null && productClassObj.getProductClassId()!=null && productClassObj.getProductClassId().intValue()==productClassTemp.getProductClassId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=productClassTemp.getProductClassId() %>" <%=selected %>><%=productClassTemp.getProductClassName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="productName">商品名称:</label>
				<input type="text" id="productName" name="productName" value="<%=productName %>" class="form-control" placeholder="请输入商品名称">
			</div>
			<div class="form-group">
				<label for="madeDate">生产日期:</label>
				<input type="text" id="madeDate" name="madeDate" class="form-control"  placeholder="请选择生产日期" value="<%=madeDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="productEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;商品信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#productEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxProductModify();">提交</button>
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
    document.productQueryForm.currentPage.value = currentPage;
    document.productQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.productQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.productQueryForm.currentPage.value = pageValue;
    documentproductQueryForm.submit();
}

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
				$('#productEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除商品信息信息*/
function productDelete(productNo) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Product/deletes",
			data : {
				productNos : productNo,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#productQueryForm").submit();
					//location.href= basePath + "Product/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

