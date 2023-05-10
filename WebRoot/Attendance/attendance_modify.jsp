<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/attendance.css" />
<div id="attendance_editDiv">
	<form id="attendanceEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">出勤id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="attendance_attendanceId_edit" name="attendance.attendanceId" value="<%=request.getParameter("attendanceId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="attendanceModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Attendance/js/attendance_modify.js"></script> 
