$(function () {
	$.ajax({
		url : "Product/" + $("#product_productNo_edit").val() + "/update",
		type : "get",
		data : {
			//productNo : $("#product_productNo_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (product, response, status) {
			$.messager.progress("close");
			if (product) { 
				$("#product_productNo_edit").val(product.productNo);
				$("#product_productNo_edit").validatebox({
					required : true,
					missingMessage : "请输入商品编号",
					editable: false
				});
				$("#product_productClassObj_productClassId_edit").combobox({
					url:"ProductClass/listAll",
					valueField:"productClassId",
					textField:"productClassName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#product_productClassObj_productClassId_edit").combobox("select", product.productClassObjPri);
						//var data = $("#product_productClassObj_productClassId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#product_productClassObj_productClassId_edit").combobox("select", data[0].productClassId);
						//}
					}
				});
				$("#product_productName_edit").val(product.productName);
				$("#product_productName_edit").validatebox({
					required : true,
					missingMessage : "请输入商品名称",
				});
				$("#product_productPhoto").val(product.productPhoto);
				$("#product_productPhotoImg").attr("src", product.productPhoto);
				$("#product_count_edit").val(product.count);
				$("#product_count_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入商品库存",
					invalidMessage : "商品库存输入不对",
				});
				$("#product_price_edit").val(product.price);
				$("#product_price_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入市场价",
					invalidMessage : "市场价输入不对",
				});
				$("#product_madeAddress_edit").val(product.madeAddress);
				$("#product_guige_edit").val(product.guige);
				$("#product_madeDate_edit").datebox({
					value: product.madeDate,
					required: true,
					showSeconds: true,
				});
				$("#product_yxq_edit").val(product.yxq);
				$("#product_beizhu_edit").val(product.beizhu);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#productModifyButton").click(function(){ 
		if ($("#productEditForm").form("validate")) {
			$("#productEditForm").form({
			    url:"Product/" +  $("#product_productNo_edit").val() + "/update",
			    onSubmit: function(){
					if($("#productEditForm").form("validate"))  {
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
			$("#productEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
