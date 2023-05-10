<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/supplier.css" /> 

<div id="supplier_manage"></div>
<div id="supplier_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="supplier_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="supplier_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="supplier_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="supplier_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="supplier_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="supplierQueryForm" method="post">
			供应商名称：<input type="text" class="textbox" id="supplierName" name="supplierName" style="width:110px" />
			联系人：<input type="text" class="textbox" id="personName" name="personName" style="width:110px" />
			联系电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="supplier_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="supplierEditDiv">
	<form id="supplierEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">供应商id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="supplier_supplierId_edit" name="supplier.supplierId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">供应商名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="supplier_supplierName_edit" name="supplier.supplierName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="supplier_personName_edit" name="supplier.personName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="supplier_telephone_edit" name="supplier.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="supplier_address_edit" name="supplier.address" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Supplier/js/supplier_manage.js"></script> 
