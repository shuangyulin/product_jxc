$(function () {
	$("#sale_productObj_productNo").combobox({
	    url:'Product/listAll',
	    valueField: "productNo",
	    textField: "productName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#sale_productObj_productNo").combobox("getData"); 
            if (data.length > 0) {
                $("#sale_productObj_productNo").combobox("select", data[0].productNo);
            }
        }
	});
	$("#sale_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#sale_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#sale_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#sale_price").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入销售单价',
		invalidMessage : '销售单价输入不对',
	});

	$("#sale_count").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入销售数量',
		invalidMessage : '销售数量输入不对',
	});

	$("#sale_saleDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#sale_employeeObj_employeeNo").combobox({
	    url:'Employee/listAll',
	    valueField: "employeeNo",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#sale_employeeObj_employeeNo").combobox("getData"); 
            if (data.length > 0) {
                $("#sale_employeeObj_employeeNo").combobox("select", data[0].employeeNo);
            }
        }
	});
	//单击添加按钮
	$("#saleAddButton").click(function () {
		//验证表单 
		if(!$("#saleAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#saleAddForm").form({
			    url:"Sale/add",
			    onSubmit: function(){
					if($("#saleAddForm").form("validate"))  { 
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
                        $("#saleAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#saleAddForm").submit();
		}
	});

	//单击清空按钮
	$("#saleClearButton").click(function () { 
		$("#saleAddForm").form("clear"); 
	});
});
