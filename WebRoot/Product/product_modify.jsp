<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/product.css" />
<div id="product_editDiv">
	<form id="productEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">商品编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_productNo_edit" name="product.productNo" value="<%=request.getParameter("productNo") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">商品类别:</span>
			<span class="inputControl">
				<input class="textbox"  id="product_productClassObj_productClassId_edit" name="product.productClassObj.productClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">商品名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_productName_edit" name="product.productName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">产品图片:</span>
			<span class="inputControl">
				<img id="product_productPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="product_productPhoto" name="product.productPhoto"/>
				<input id="productPhotoFile" name="productPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">商品库存:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_count_edit" name="product.count" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">市场价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_price_edit" name="product.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">产地:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_madeAddress_edit" name="product.madeAddress" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">规格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_guige_edit" name="product.guige" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">生产日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_madeDate_edit" name="product.madeDate" />

			</span>

		</div>
		<div>
			<span class="label">有效期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_yxq_edit" name="product.yxq" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">备注:</span>
			<span class="inputControl">
				<textarea id="product_beizhu_edit" name="product.beizhu" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="productModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Product/js/product_modify.js"></script> 
