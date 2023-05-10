<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/attendance.css" />
<div id="attendanceAddDiv">
	<form id="attendanceAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">员工:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="attendance_employeeObj_employeeNo" name="attendance.employeeObj.employeeNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">年份:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="attendance_year" name="attendance.year" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">月份:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="attendance_month" name="attendance.month" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">应到天数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="attendance_shouldComeDays" name="attendance.shouldComeDays" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">请假天数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="attendance_leaveDays" name="attendance.leaveDays" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">缺勤天数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="attendance_absenceDays" name="attendance.absenceDays" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="attendanceAddButton" class="easyui-linkbutton">添加</a>
			<a id="attendanceClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Attendance/js/attendance_add.js"></script> 
