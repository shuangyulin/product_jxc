$(function () {
	$.ajax({
		url : "Attendance/" + $("#attendance_attendanceId_edit").val() + "/update",
		type : "get",
		data : {
			//attendanceId : $("#attendance_attendanceId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (attendance, response, status) {
			$.messager.progress("close");
			if (attendance) { 
				$("#attendance_attendanceId_edit").val(attendance.attendanceId);
				$("#attendance_attendanceId_edit").validatebox({
					required : true,
					missingMessage : "请输入出勤id",
					editable: false
				});
				$("#attendance_employeeObj_employeeNo_edit").combobox({
					url:"Employee/listAll",
					valueField:"employeeNo",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#attendance_employeeObj_employeeNo_edit").combobox("select", attendance.employeeObjPri);
						//var data = $("#attendance_employeeObj_employeeNo_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#attendance_employeeObj_employeeNo_edit").combobox("select", data[0].employeeNo);
						//}
					}
				});
				$("#attendance_year_edit").val(attendance.year);
				$("#attendance_year_edit").validatebox({
					required : true,
					missingMessage : "请输入年份",
				});
				$("#attendance_month_edit").val(attendance.month);
				$("#attendance_month_edit").validatebox({
					required : true,
					missingMessage : "请输入月份",
				});
				$("#attendance_shouldComeDays_edit").val(attendance.shouldComeDays);
				$("#attendance_shouldComeDays_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入应到天数",
					invalidMessage : "应到天数输入不对",
				});
				$("#attendance_leaveDays_edit").val(attendance.leaveDays);
				$("#attendance_leaveDays_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入请假天数",
					invalidMessage : "请假天数输入不对",
				});
				$("#attendance_absenceDays_edit").val(attendance.absenceDays);
				$("#attendance_absenceDays_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入缺勤天数",
					invalidMessage : "缺勤天数输入不对",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#attendanceModifyButton").click(function(){ 
		if ($("#attendanceEditForm").form("validate")) {
			$("#attendanceEditForm").form({
			    url:"Attendance/" +  $("#attendance_attendanceId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#attendanceEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#attendanceEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
