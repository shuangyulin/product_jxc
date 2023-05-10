<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/purchase.css" /> 

<div id="purchase_manage"></div>
<div id="purchase_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="purchase_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="purchase_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="purchase_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="purchase_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="purchase_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="purchaseQueryForm" method="post">
			进货商品：<input class="textbox" type="text" id="productObj_productNo_query" name="productObj.productNo" style="width: auto"/>
			供应商：<input class="textbox" type="text" id="supplierObj_supplierId_query" name="supplierObj.supplierId" style="width: auto"/>
			进货日期：<input type="text" id="purchaseDate" name="purchaseDate" class="easyui-datebox" editable="false" style="width:100px">
			进货员工：<input class="textbox" type="text" id="employeeObj_employeeNo_query" name="employeeObj.employeeNo" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="purchase_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="purchaseEditDiv">
	<form id="purchaseEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">进货id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_purchaseId_edit" name="purchase.purchaseId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="Purchase/js/purchase_manage.js"></script> 
