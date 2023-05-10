var attendance_manage_tool = null; 
$(function () { 
	initAttendanceManageTool(); //建立Attendance管理对象
	attendance_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#attendance_manage").datagrid({
		url : 'Attendance/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "attendanceId",
		sortOrder : "desc",
		toolbar : "#attendance_manage_tool",
		columns : [[
			{
				field : "attendanceId",
				title : "出勤id",
				width : 70,
			},
			{
				field : "employeeObj",
				title : "员工",
				width : 140,
			},
			{
				field : "year",
				title : "年份",
				width : 140,
			},
			{
				field : "month",
				title : "月份",
				width : 140,
			},
			{
				field : "shouldComeDays",
				title : "应到天数",
				width : 70,
			},
			{
				field : "leaveDays",
				title : "请假天数",
				width : 70,
			},
			{
				field : "absenceDays",
				title : "缺勤天数",
				width : 70,
			},
		]],
	});

	$("#attendanceEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#attendanceEditForm").form("validate")) {
					//验证表单 
					if(!$("#attendanceEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#attendanceEditForm").form({
						    url:"Attendance/" + $("#attendance_attendanceId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#attendanceEditDiv").dialog("close");
			                        attendance_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#attendanceEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#attendanceEditDiv").dialog("close");
				$("#attendanceEditForm").form("reset"); 
			},
		}],
	});
});

function initAttendanceManageTool() {
	attendance_manage_tool = {
		init: function() {
			$.ajax({
				url : "Employee/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#employeeObj_employeeNo_query").combobox({ 
					    valueField:"employeeNo",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{employeeNo:"",name:"不限制"});
					$("#employeeObj_employeeNo_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#attendance_manage").datagrid("reload");
		},
		redo : function () {
			$("#attendance_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#attendance_manage").datagrid("options").queryParams;
			queryParams["employeeObj.employeeNo"] = $("#employeeObj_employeeNo_query").combobox("getValue");
			queryParams["year"] = $("#year").val();
			queryParams["month"] = $("#month").val();
			$("#attendance_manage").datagrid("options").queryParams=queryParams; 
			$("#attendance_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#attendanceQueryForm").form({
			    url:"Attendance/OutToExcel",
			});
			//提交表单
			$("#attendanceQueryForm").submit();
		},
		remove : function () {
			var rows = $("#attendance_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var attendanceIds = [];
						for (var i = 0; i < rows.length; i ++) {
							attendanceIds.push(rows[i].attendanceId);
						}
						$.ajax({
							type : "POST",
							url : "Attendance/deletes",
							data : {
								attendanceIds : attendanceIds.join(","),
							},
							beforeSend : function () {
								$("#attendance_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#attendance_manage").datagrid("loaded");
									$("#attendance_manage").datagrid("load");
									$("#attendance_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#attendance_manage").datagrid("loaded");
									$("#attendance_manage").datagrid("load");
									$("#attendance_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#attendance_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Attendance/" + rows[0].attendanceId +  "/update",
					type : "get",
					data : {
						//attendanceId : rows[0].attendanceId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (attendance, response, status) {
						$.messager.progress("close");
						if (attendance) { 
							$("#attendanceEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
