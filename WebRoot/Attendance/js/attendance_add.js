$(function () {
	$("#attendance_employeeObj_employeeNo").combobox({
	    url:'Employee/listAll',
	    valueField: "employeeNo",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#attendance_employeeObj_employeeNo").combobox("getData"); 
            if (data.length > 0) {
                $("#attendance_employeeObj_employeeNo").combobox("select", data[0].employeeNo);
            }
        }
	});
	$("#attendance_year").validatebox({
		required : true, 
		missingMessage : '请输入年份',
	});

	$("#attendance_month").validatebox({
		required : true, 
		missingMessage : '请输入月份',
	});

	$("#attendance_shouldComeDays").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入应到天数',
		invalidMessage : '应到天数输入不对',
	});

	$("#attendance_leaveDays").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入请假天数',
		invalidMessage : '请假天数输入不对',
	});

	$("#attendance_absenceDays").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入缺勤天数',
		invalidMessage : '缺勤天数输入不对',
	});

	//单击添加按钮
	$("#attendanceAddButton").click(function () {
		//验证表单 
		if(!$("#attendanceAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#attendanceAddForm").form({
			    url:"Attendance/add",
			    onSubmit: function(){
					if($("#attendanceAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#attendanceAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#attendanceAddForm").submit();
		}
	});

	//单击清空按钮
	$("#attendanceClearButton").click(function () { 
		$("#attendanceAddForm").form("clear"); 
	});
});
