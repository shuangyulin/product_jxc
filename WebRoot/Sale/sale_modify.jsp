<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/sale.css" />
<div id="sale_editDiv">
	<form id="saleEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">销售id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="sale_saleId_edit" name="sale.saleId" value="<%=request.getParameter("saleId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">销售商品:</span>
			<span class="inputControl">
				<input class="textbox"  id="sale_productObj_productNo_edit" name="sale.productObj.productNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">销售客户:</span>
			<span class="inputControl">
				<input class="textbox"  id="sale_userObj_user_name_edit" name="sale.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">销售单价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="sale_price_edit" name="sale.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">销售数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="sale_count_edit" name="sale.count" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">销售日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="sale_saleDate_edit" name="sale.saleDate" />

			</span>

		</div>
		<div>
			<span class="label">销售员工:</span>
			<span class="inputControl">
				<input class="textbox"  id="sale_employeeObj_employeeNo_edit" name="sale.employeeObj.employeeNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">备注:</span>
			<span class="inputControl">
				<textarea id="sale_memo_edit" name="sale.memo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="saleModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Sale/js/sale_modify.js"></script> 
