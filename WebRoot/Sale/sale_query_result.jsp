<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/sale.css" /> 

<div id="sale_manage"></div>
<div id="sale_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="sale_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="sale_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="sale_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="sale_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="sale_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="saleQueryForm" method="post">
			销售商品：<input class="textbox" type="text" id="productObj_productNo_query" name="productObj.productNo" style="width: auto"/>
			销售客户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			销售日期：<input type="text" id="saleDate" name="saleDate" class="easyui-datebox" editable="false" style="width:100px">
			销售员工：<input class="textbox" type="text" id="employeeObj_employeeNo_query" name="employeeObj.employeeNo" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="sale_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="saleEditDiv">
	<form id="saleEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">销售id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="sale_saleId_edit" name="sale.saleId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="Sale/js/sale_manage.js"></script> 
