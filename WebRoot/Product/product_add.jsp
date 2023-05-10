<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/product.css" />
<div id="productAddDiv">
	<form id="productAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">商品编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_productNo" name="product.productNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">商品类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_productClassObj_productClassId" name="product.productClassObj.productClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">商品名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_productName" name="product.productName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">产品图片:</span>
			<span class="inputControl">
				<input id="productPhotoFile" name="productPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">商品库存:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_count" name="product.count" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">市场价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_price" name="product.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">产地:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_madeAddress" name="product.madeAddress" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">规格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_guige" name="product.guige" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">生产日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_madeDate" name="product.madeDate" />

			</span>

		</div>
		<div>
			<span class="label">有效期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_yxq" name="product.yxq" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">备注:</span>
			<span class="inputControl">
				<textarea id="product_beizhu" name="product.beizhu" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="productAddButton" class="easyui-linkbutton">添加</a>
			<a id="productClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Product/js/product_add.js"></script> 
