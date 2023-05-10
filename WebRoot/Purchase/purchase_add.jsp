<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/purchase.css" />
<div id="purchaseAddDiv">
	<form id="purchaseAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">进货商品:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_productObj_productNo" name="purchase.productObj.productNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">供应商:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_supplierObj_supplierId" name="purchase.supplierObj.supplierId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">进货单价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_price" name="purchase.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">进货数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_count" name="purchase.count" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">进货日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_purchaseDate" name="purchase.purchaseDate" />

			</span>

		</div>
		<div>
			<span class="label">进货员工:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_employeeObj_employeeNo" name="purchase.employeeObj.employeeNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">备注:</span>
			<span class="inputControl">
				<textarea id="purchase_memo" name="purchase.memo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="purchaseAddButton" class="easyui-linkbutton">添加</a>
			<a id="purchaseClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Purchase/js/purchase_add.js"></script> 
