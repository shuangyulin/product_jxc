<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/purchase.css" />
<div id="purchase_editDiv">
	<form id="purchaseEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">进货id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_purchaseId_edit" name="purchase.purchaseId" value="<%=request.getParameter("purchaseId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">进货商品:</span>
			<span class="inputControl">
				<input class="textbox"  id="purchase_productObj_productNo_edit" name="purchase.productObj.productNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">供应商:</span>
			<span class="inputControl">
				<input class="textbox"  id="purchase_supplierObj_supplierId_edit" name="purchase.supplierObj.supplierId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">进货单价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_price_edit" name="purchase.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">进货数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_count_edit" name="purchase.count" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">进货日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_purchaseDate_edit" name="purchase.purchaseDate" />

			</span>

		</div>
		<div>
			<span class="label">进货员工:</span>
			<span class="inputControl">
				<input class="textbox"  id="purchase_employeeObj_employeeNo_edit" name="purchase.employeeObj.employeeNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">备注:</span>
			<span class="inputControl">
				<textarea id="purchase_memo_edit" name="purchase.memo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="purchaseModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Purchase/js/purchase_modify.js"></script> 
