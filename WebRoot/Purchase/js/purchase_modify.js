$(function () {
	$.ajax({
		url : "Purchase/" + $("#purchase_purchaseId_edit").val() + "/update",
		type : "get",
		data : {
			//purchaseId : $("#purchase_purchaseId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (purchase, response, status) {
			$.messager.progress("close");
			if (purchase) { 
				$("#purchase_purchaseId_edit").val(purchase.purchaseId);
				$("#purchase_purchaseId_edit").validatebox({
					required : true,
					missingMessage : "请输入进货id",
					editable: false
				});
				$("#purchase_productObj_productNo_edit").combobox({
					url:"Product/listAll",
					valueField:"productNo",
					textField:"productName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#purchase_productObj_productNo_edit").combobox("select", purchase.productObjPri);
						//var data = $("#purchase_productObj_productNo_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#purchase_productObj_productNo_edit").combobox("select", data[0].productNo);
						//}
					}
				});
				$("#purchase_supplierObj_supplierId_edit").combobox({
					url:"Supplier/listAll",
					valueField:"supplierId",
					textField:"supplierName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#purchase_supplierObj_supplierId_edit").combobox("select", purchase.supplierObjPri);
						//var data = $("#purchase_supplierObj_supplierId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#purchase_supplierObj_supplierId_edit").combobox("select", data[0].supplierId);
						//}
					}
				});
				$("#purchase_price_edit").val(purchase.price);
				$("#purchase_price_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入进货单价",
					invalidMessage : "进货单价输入不对",
				});
				$("#purchase_count_edit").val(purchase.count);
				$("#purchase_count_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入进货数量",
					invalidMessage : "进货数量输入不对",
				});
				$("#purchase_purchaseDate_edit").datebox({
					value: purchase.purchaseDate,
					required: true,
					showSeconds: true,
				});
				$("#purchase_employeeObj_employeeNo_edit").combobox({
					url:"Employee/listAll",
					valueField:"employeeNo",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#purchase_employeeObj_employeeNo_edit").combobox("select", purchase.employeeObjPri);
						//var data = $("#purchase_employeeObj_employeeNo_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#purchase_employeeObj_employeeNo_edit").combobox("select", data[0].employeeNo);
						//}
					}
				});
				$("#purchase_memo_edit").val(purchase.memo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#purchaseModifyButton").click(function(){ 
		if ($("#purchaseEditForm").form("validate")) {
			$("#purchaseEditForm").form({
			    url:"Purchase/" +  $("#purchase_purchaseId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#purchaseEditForm").form("validate"))  {
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
			$("#purchaseEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
