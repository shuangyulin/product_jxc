<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/sale.css" />
<div id="saleAddDiv">
	<form id="saleAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">销售商品:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="sale_productObj_productNo" name="sale.productObj.productNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">销售客户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="sale_userObj_user_name" name="sale.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">销售单价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="sale_price" name="sale.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">销售数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="sale_count" name="sale.count" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">销售日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="sale_saleDate" name="sale.saleDate" />

			</span>

		</div>
		<div>
			<span class="label">销售员工:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="sale_employeeObj_employeeNo" name="sale.employeeObj.employeeNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">备注:</span>
			<span class="inputControl">
				<textarea id="sale_memo" name="sale.memo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="saleAddButton" class="easyui-linkbutton">添加</a>
			<a id="saleClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Sale/js/sale_add.js"></script> 
