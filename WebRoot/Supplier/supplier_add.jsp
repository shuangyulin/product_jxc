<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/supplier.css" />
<div id="supplierAddDiv">
	<form id="supplierAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">供应商名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="supplier_supplierName" name="supplier.supplierName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="supplier_personName" name="supplier.personName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="supplier_telephone" name="supplier.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="supplier_address" name="supplier.address" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="supplierAddButton" class="easyui-linkbutton">添加</a>
			<a id="supplierClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Supplier/js/supplier_add.js"></script> 
