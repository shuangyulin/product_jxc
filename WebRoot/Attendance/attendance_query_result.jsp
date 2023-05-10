<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/attendance.css" /> 

<div id="attendance_manage"></div>
<div id="attendance_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="attendance_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="attendance_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="attendance_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="attendance_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="attendance_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="attendanceQueryForm" method="post">
			员工：<input class="textbox" type="text" id="employeeObj_employeeNo_query" name="employeeObj.employeeNo" style="width: auto"/>
			年份：<input type="text" class="textbox" id="year" name="year" style="width:110px" />
			月份：<input type="text" class="textbox" id="month" name="month" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="attendance_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="attendanceEditDiv">
	<form id="attendanceEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">出勤id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="attendance_attendanceId_edit" name="attendance.attendanceId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">员工:</span>
			<span class="inputControl">
				<input class="textbox"  id="attendance_employeeObj_employeeNo_edit" name="attendance.employeeObj.employeeNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">年份:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="attendance_year_edit" name="attendance.year" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">月份:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="attendance_month_edit" name="attendance.month" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">应到天数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="attendance_shouldComeDays_edit" name="attendance.shouldComeDays" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">请假天数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="attendance_leaveDays_edit" name="attendance.leaveDays" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">缺勤天数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="attendance_absenceDays_edit" name="attendance.absenceDays" style="width:80px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Attendance/js/attendance_manage.js"></script> 
