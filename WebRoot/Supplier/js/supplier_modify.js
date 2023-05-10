$(function () {
	$.ajax({
		url : "Supplier/" + $("#supplier_supplierId_edit").val() + "/update",
		type : "get",
		data : {
			//supplierId : $("#supplier_supplierId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (supplier, response, status) {
			$.messager.progress("close");
			if (supplier) { 
				$("#supplier_supplierId_edit").val(supplier.supplierId);
				$("#supplier_supplierId_edit").validatebox({
					required : true,
					missingMessage : "请输入供应商id",
					editable: false
				});
				$("#supplier_supplierName_edit").val(supplier.supplierName);
				$("#supplier_supplierName_edit").validatebox({
					required : true,
					missingMessage : "请输入供应商名称",
				});
				$("#supplier_personName_edit").val(supplier.personName);
				$("#supplier_personName_edit").validatebox({
					required : true,
					missingMessage : "请输入联系人",
				});
				$("#supplier_telephone_edit").val(supplier.telephone);
				$("#supplier_address_edit").val(supplier.address);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#supplierModifyButton").click(function(){ 
		if ($("#supplierEditForm").form("validate")) {
			$("#supplierEditForm").form({
			    url:"Supplier/" +  $("#supplier_supplierId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#supplierEditForm").form("validate"))  {
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
			$("#supplierEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
