<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/employee.css" /> 

<div id="employee_manage"></div>
<div id="employee_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="employee_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="employee_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="employee_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="employee_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="employee_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="employeeQueryForm" method="post">
			员工编号：<input type="text" class="textbox" id="employeeNo" name="employeeNo" style="width:110px" />
			姓名：<input type="text" class="textbox" id="name" name="name" style="width:110px" />
			所在部门：<input type="text" class="textbox" id="department" name="department" style="width:110px" />
			出生日期：<input type="text" id="birthDate" name="birthDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="employee_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="employeeEditDiv">
	<form id="employeeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">员工编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_employeeNo_edit" name="employee.employeeNo" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_password_edit" name="employee.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_name_edit" name="employee.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_sex_edit" name="employee.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">员工照片:</span>
			<span class="inputControl">
				<img id="employee_photoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="employee_photo" name="employee.photo"/>
				<input id="photoFile" name="photoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">所在部门:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_department_edit" name="employee.department" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_birthDate_edit" name="employee.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_telephone_edit" name="employee.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_address_edit" name="employee.address" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Employee/js/employee_manage.js"></script> 
