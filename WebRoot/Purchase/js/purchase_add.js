$(function () {
	$("#purchase_productObj_productNo").combobox({
	    url:'Product/listAll',
	    valueField: "productNo",
	    textField: "productName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#purchase_productObj_productNo").combobox("getData"); 
            if (data.length > 0) {
                $("#purchase_productObj_productNo").combobox("select", data[0].productNo);
            }
        }
	});
	$("#purchase_supplierObj_supplierId").combobox({
	    url:'Supplier/listAll',
	    valueField: "supplierId",
	    textField: "supplierName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#purchase_supplierObj_supplierId").combobox("getData"); 
            if (data.length > 0) {
                $("#purchase_supplierObj_supplierId").combobox("select", data[0].supplierId);
            }
        }
	});
	$("#purchase_price").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入进货单价',
		invalidMessage : '进货单价输入不对',
	});

	$("#purchase_count").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入进货数量',
		invalidMessage : '进货数量输入不对',
	});

	$("#purchase_purchaseDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#purchase_employeeObj_employeeNo").combobox({
	    url:'Employee/listAll',
	    valueField: "employeeNo",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#purchase_employeeObj_employeeNo").combobox("getData"); 
            if (data.length > 0) {
                $("#purchase_employeeObj_employeeNo").combobox("select", data[0].employeeNo);
            }
        }
	});
	//单击添加按钮
	$("#purchaseAddButton").click(function () {
		//验证表单 
		if(!$("#purchaseAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#purchaseAddForm").form({
			    url:"Purchase/add",
			    onSubmit: function(){
					if($("#purchaseAddForm").form("validate"))  { 
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
                        $("#purchaseAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#purchaseAddForm").submit();
		}
	});

	//单击清空按钮
	$("#purchaseClearButton").click(function () { 
		$("#purchaseAddForm").form("clear"); 
	});
});
