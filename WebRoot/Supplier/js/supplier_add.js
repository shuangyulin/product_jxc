$(function () {
	$("#supplier_supplierName").validatebox({
		required : true, 
		missingMessage : '请输入供应商名称',
	});

	$("#supplier_personName").validatebox({
		required : true, 
		missingMessage : '请输入联系人',
	});

	//单击添加按钮
	$("#supplierAddButton").click(function () {
		//验证表单 
		if(!$("#supplierAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#supplierAddForm").form({
			    url:"Supplier/add",
			    onSubmit: function(){
					if($("#supplierAddForm").form("validate"))  { 
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
                        $("#supplierAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#supplierAddForm").submit();
		}
	});

	//单击清空按钮
	$("#supplierClearButton").click(function () { 
		$("#supplierAddForm").form("clear"); 
	});
});
