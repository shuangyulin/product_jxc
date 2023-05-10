<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Sale" %>
<%@ page import="com.chengxusheji.po.Employee" %>
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Sale> saleList = (List<Sale>)request.getAttribute("saleList");
    //获取所有的employeeObj信息
    List<Employee> employeeList = (List<Employee>)request.getAttribute("employeeList");
    //获取所有的productObj信息
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Product productObj = (Product)request.getAttribute("productObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String saleDate = (String)request.getAttribute("saleDate"); //销售日期查询关键字
    Employee employeeObj = (Employee)request.getAttribute("employeeObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>销售信息查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#saleListPanel" aria-controls="saleListPanel" role="tab" data-toggle="tab">销售信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Sale/sale_frontAdd.jsp" style="display:none;">添加销售信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="saleListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>销售id</td><td>销售商品</td><td>销售客户</td><td>销售单价</td><td>销售数量</td><td>销售日期</td><td>销售员工</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<saleList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Sale sale = saleList.get(i); //获取到销售信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=sale.getSaleId() %></td>
 											<td><%=sale.getProductObj().getProductName() %></td>
 											<td><%=sale.getUserObj().getName() %></td>
 											<td><%=sale.getPrice() %></td>
 											<td><%=sale.getCount() %></td>
 											<td><%=sale.getSaleDate() %></td>
 											<td><%=sale.getEmployeeObj().getName() %></td>
 											<td>
 												<a href="<%=basePath  %>Sale/<%=sale.getSaleId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="saleEdit('<%=sale.getSaleId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="saleDelete('<%=sale.getSaleId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

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
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>销售信息查询</h1>
		</div>
		<form name="saleQueryForm" id="saleQueryForm" action="<%=basePath %>Sale/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="productObj_productNo">销售商品：</label>
                <select id="productObj_productNo" name="productObj.productNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Product productTemp:productList) {
	 					String selected = "";
 					if(productObj!=null && productObj.getProductNo()!=null && productObj.getProductNo().equals(productTemp.getProductNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=productTemp.getProductNo() %>" <%=selected %>><%=productTemp.getProductName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">销售客户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="saleDate">销售日期:</label>
				<input type="text" id="saleDate" name="saleDate" class="form-control"  placeholder="请选择销售日期" value="<%=saleDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <div class="form-group">
            	<label for="employeeObj_employeeNo">销售员工：</label>
                <select id="employeeObj_employeeNo" name="employeeObj.employeeNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Employee employeeTemp:employeeList) {
	 					String selected = "";
 					if(employeeObj!=null && employeeObj.getEmployeeNo()!=null && employeeObj.getEmployeeNo().equals(employeeTemp.getEmployeeNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=employeeTemp.getEmployeeNo() %>" <%=selected %>><%=employeeTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="saleEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;销售信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
                <div class="input-group date sale_saleDate_edit col-md-12" data-link-field="sale_saleDate_edit"  data-link-format="yyyy-mm-dd">
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
		</form> 
	    <style>#saleEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxSaleModify();">提交</button>
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
    document.saleQueryForm.currentPage.value = currentPage;
    document.saleQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.saleQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.saleQueryForm.currentPage.value = pageValue;
    documentsaleQueryForm.submit();
}

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
				$('#saleEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除销售信息信息*/
function saleDelete(saleId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Sale/deletes",
			data : {
				saleIds : saleId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#saleQueryForm").submit();
					//location.href= basePath + "Sale/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

