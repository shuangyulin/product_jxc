$(function () {
	$.ajax({
		url : "Sale/" + $("#sale_saleId_edit").val() + "/update",
		type : "get",
		data : {
			//saleId : $("#sale_saleId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (sale, response, status) {
			$.messager.progress("close");
			if (sale) { 
				$("#sale_saleId_edit").val(sale.saleId);
				$("#sale_saleId_edit").validatebox({
					required : true,
					missingMessage : "请输入销售id",
					editable: false
				});
				$("#sale_productObj_productNo_edit").combobox({
					url:"Product/listAll",
					valueField:"productNo",
					textField:"productName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#sale_productObj_productNo_edit").combobox("select", sale.productObjPri);
						//var data = $("#sale_productObj_productNo_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#sale_productObj_productNo_edit").combobox("select", data[0].productNo);
						//}
					}
				});
				$("#sale_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#sale_userObj_user_name_edit").combobox("select", sale.userObjPri);
						//var data = $("#sale_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#sale_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#sale_price_edit").val(sale.price);
				$("#sale_price_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入销售单价",
					invalidMessage : "销售单价输入不对",
				});
				$("#sale_count_edit").val(sale.count);
				$("#sale_count_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入销售数量",
					invalidMessage : "销售数量输入不对",
				});
				$("#sale_saleDate_edit").datebox({
					value: sale.saleDate,
					required: true,
					showSeconds: true,
				});
				$("#sale_employeeObj_employeeNo_edit").combobox({
					url:"Employee/listAll",
					valueField:"employeeNo",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#sale_employeeObj_employeeNo_edit").combobox("select", sale.employeeObjPri);
						//var data = $("#sale_employeeObj_employeeNo_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#sale_employeeObj_employeeNo_edit").combobox("select", data[0].employeeNo);
						//}
					}
				});
				$("#sale_memo_edit").val(sale.memo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#saleModifyButton").click(function(){ 
		if ($("#saleEditForm").form("validate")) {
			$("#saleEditForm").form({
			    url:"Sale/" +  $("#sale_saleId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#saleEditForm").form("validate"))  {
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
			$("#saleEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
