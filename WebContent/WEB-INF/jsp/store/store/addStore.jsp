<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<%@ include file="../../common/ace.jsp"%>
<style>
	.ace-file-input{width:180px; position: relative;  height: 38px; line-height: 38px; margin:0; display:inline-block;float:left}
	.upload{    margin-left: 15px;display:none;}
</style>
<script type="text/javascript">
	 function checkRealImage(elementId) {
		var text = $("#"+elementId).contents().find('pre').text();
		var textJo = JSON.parse(text);
		if(textJo.respCode != '0000') {
			showMessage("图片上传失败！");
		}
	} 
$(function() {
	//存放店铺信息
	 var storeInfo = {}; 
	
	//select多选 初始化方法
	$(".choose_select").chosen(); 
	$('.date-picker').datepicker({autoclose:true}).next().on(ace.click_event, function(){
		$(this).prev().focus();
	});
	$('.number').ace_spinner({value:0,min:0,max:999999,step:1, touch_spinner: true, icon_up:'icon-caret-up', icon_down:'icon-caret-down'});
	$('.money').ace_spinner({value:0,min:0,step:1, max:999999,touch_spinner: true, icon_up:'icon-caret-up', icon_down:'icon-caret-down'});
	$('.rate').ace_spinner({value:0,min:0,max:100,step:1,  on_sides: true, icon_up:'icon-plus smaller-75', icon_down:'icon-minus smaller-75', btn_up_class:'btn-success' , btn_down_class:'btn-danger'});
	$('.timepicker').timepicker({
		minuteStep: 1,
		showSeconds: true,
		showMeridian: false
	}).next().on(ace.click_event, function(){
		$(this).prev().focus();
	});
	new biz.select({//状态下拉
	    id:"#edit_settlementMethod",
	    url:"<m:url value='/dictInfo/getDictByTypeCode.do?dictTypeCode=settlementMethod'/>",
	});
	//checkbox
	$('#edit_proInvoiceFlag').removeAttr('checked').on('click', function(){
		if(this.checked) {$("#edit_proInvoiceFlag").val("1");}
		else {$("#edit_proInvoiceFlag").val("0");}
	});

	$('input[type="file"]').ace_file_input({
		no_file:'请选择...',
		btn_choose:'选择',
		btn_change:'更换',
		droppable:false,
		onchange:null,
		thumbnail:false,
		whitelist:'gif|png|jpg|jpeg',
		onchange:function(){
			console.log(this);
		}
		
	});
	
	$('#realImage_submit').click(function(){
		
		if(!$("#edit_storeName").val()) {
			showMessage("请先填写店铺名称！");
			return;
		}
		$('#image_storeName').val($("#edit_storeName").val());
		$('#realImageForm').submit();
		
	}); 
	
	 function getImageUrl(elementId) {
		var text = $('#' + elementId).contents().find('pre').text();
		var textJo = JSON.parse(text);
		var picAddr = textJo.picAddr;
		
		return picAddr;
	} 
	
	//绑定提交按钮click事件
	$("#submit").click(function() {
		$("#submit").prop('disabled', true).css({'cursor':'not-allowed'});
		showMessage("正在处理...");
		/* if(!biz.validate("valid",$('#storeFormEdit')[0])){
			showWarn("数据验证失败",3000);
			$("#submit").prop('disabled', false).css({'cursor':'pointer'});
			return;
		} */		
		//var pre = $('#realImageIframe').contentWindow.document.find('pre');
		 var realImageUrl = getImageUrl('realImageIframe1'); 
		
        var storeName = $("#edit_storeName").val();
        var brandId=$("#edit_brandId").val();
     	var storeAddress=$("#edit_storeAddress").val();
    	var storeTel=$("#edit_storeTel").val();
  		var workTimeBegin=$("#edit_workTimeBegin").val();
  		var workTimeEnd=$("#edit_workTimeEnd").val();
  		var storeOwnerName=$("#edit_storeOwnerName").val();
  		var storeOwnerTel=$("#edit_storeOwnerTel").val();
		var settlementMethod=$("#edit_settlementMethod").val();
		var proInvoiceFlag=$("#edit_proInvoiceFlag").val()=="on"?"1":"0";
		var registrant=$("#edit_registrant").val();
		var registDate=$("#edit_registDate").val();
		var operateDate=$("#edit_operateDate").val();
		var remark=$("#edit_remark").val();
		var averageSales=$("#edit_averageSales").val();
		var elmSale=$("#edit_elmSale").val();
		var meituanSale=$("#edit_meituanSale").val();
		var baiduSale=$("#edit_baiduSale").val();
		var elmRate=$("#edit_elmRate").val();
		var meituanRate=$("#edit_meituanRate").val();
		var baiduRate=$("#edit_baiduRate").val();
		var realImagePath1=$("#edit_realImagePath1").val();
		var realImagePath2=$("#edit_realImagePath2").val();
		var realImagePath3=$("#edit_realImagePath3").val();
		var businessLicenseImg=$("#edit_businessLicenseImg").val();
		var healthLicenseImg=$("#edit_healthLicenseImg").val();
		var menuImg=$("#edit_menuImg").val();
		var corporateIdcardFront=$("#edit_corporateIdcardFront").val();
		var corporateIdcardBack=$("#edit_corporateIdcardBack").val();
		var canteenImg=$("#edit_canteenImg").val();
		var kitchenImg=$("#edit_kitchenImg").val();
		var doorImg=$("#edit_doorImg").val();
		var corporateWithidcardFront=$("#edit_corporateWithidcardFront").val();
		var corporateWithidcardBack=$("#edit_corporateWithidcardBack").val();
		var ownerUserId=$("#edit_ownerUserId").val();
		var paramDatas = {
			storeName:storeName,
	        brandId:brandId,
	     	storeAddress:storeAddress,
	    	storeTel:storeTel,
	  		workTimeBegin:workTimeBegin,
	  		workTimeEnd:workTimeEnd,
	  		storeOwnerName:storeOwnerName,
	  		storeOwnerTel:storeOwnerTel,
			settlementMethod:settlementMethod,
			proInvoiceFlag:proInvoiceFlag,
			registrant:registrant,
			registDate:registDate,
			operateDate:operateDate,
			remark:remark,
			averageSales:averageSales,
			elmSale:elmSale,
			meituanSale:meituanSale,
			baiduSale:baiduSale,
			elmRate:elmRate,
			meituanRate:meituanRate,
			baiduRate:baiduRate,
			realImagePath1:realImagePath1,
			realImagePath2:realImagePath2,
			realImagePath3:realImagePath3,
			businessLicenseImg:businessLicenseImg,
			healthLicenseImg:healthLicenseImg,
			menuImg:menuImg,
			corporateIdcardFront:corporateIdcardFront,
			corporateIdcardBack:corporateIdcardBack,
			canteenImg:canteenImg,
			kitchenImg:kitchenImg,
			doorImg:doorImg,
			corporateWithidcardFront:corporateWithidcardFront,
			corporateWithidcardBack:corporateWithidcardBack,
			ownerUserId:ownerUserId
		};
		$.ajax({
 		   type: "post",
 		   url: "<m:url value='/store/addStore.do'/>",
 		   data: paramDatas,
 		   cache: false,
 		   dataType:"json",
 		   /* processData: false,
           contentType: false,  */
           success : function(d) {
				if(d.status){
					showMessage(d.message,"","",function(){
						window.parent.closeAdd();
			     		window.parent.doSearch();
					});
				}else{
					showMessage(d.message);
				}
			},
           error: function() {
          	showMessage("请求失败");
           }
 		});
     	
		
	});
	

	/*编辑表单数据验证*/
	/* new biz.validate({
		id:"#storeFormEdit",
		rules:{
			"storeName":{required : true},
			"storeAddress":{required : true},
			"workTimeBegin":{required : true},
			"workTimeEnd":{required : true},
			"storeOwnerTel" : {
				required : true,
				maxlength : 11,
				naturalnum:true
			},
		}
	});  */
});
</script>
</head>
  
<body>
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<input type="hidden" id="edit_storeId" name="storeId" type="text" value="${store.storeId}"/>
		<table class="table">
			<tr>
				<td class="inputLabelTd">店铺名称：</td>
				<td class="inputTd">
					<input id="edit_storeName" name="storeName" type="text" class="text" value="${store.storeName}"/>
				</td>
				<td class="inputLabelTd">所属品牌：</td>
				<td class="inputTd">
					<select class="search_select choose_select" name="brandId" id="edit_brandId">
						<option value="">--请选择--</option>
						<c:forEach var="brand" items="${brand}">
							<option value="${brand.brandId}"> <c:out value="${brand.brandName}"></c:out> </option>
			             </c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">店铺地址：</td>
				<td class="inputTd">
					<input id="edit_storeAddress" name="storeAddress" type="text" class="text" value="${store.storeAddress}"/>
				</td>
				<td class="inputLabelTd">店铺联系电话：</td>
				<td class="inputTd">
					<span class="input-icon">
						<input id="edit_storeTel" name="storeTel" type="text" class="text" value="${store.storeTel}"/>
						<i class="icon-phone green"></i>
					</span>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">营业时间起：</td>
				<td class="inputTd">
					<div class="input-group bootstrap-timepicker">
						<input class="timepicker text" name="workTimeBegin" id="edit_workTimeBegin" type="text" />
						<span>
							<i class="icon-time bigger-110"></i>
						</span>
					</div>
				</td>
				<td class="inputLabelTd">营业时间止：</td>
				<td class="inputTd">
					<div class="input-group bootstrap-timepicker">
						<input class="timepicker text" name="workTimeEnd" id="edit_workTimeEnd" type="text" />
						<span>
							<i class="icon-time bigger-110"></i>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">店长姓名：</td>
				<td class="inputTd">
					<input id="edit_storeOwnerName" name="storeOwnerName" type="text" class="text" value="${store.storeOwnerName}"/>
				</td>
				<td class="inputLabelTd">店长电话：</td>
				<td class="inputTd">
					<span class="input-icon">
						<input id="edit_storeOwnerTel" name="storeOwnerTel" type="text" class="text" value="${store.storeOwnerTel}"/>
						<i class="icon-phone green"></i>
					</span>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">结算方式：</td>
				<td class="inputTd">
					<select class="search_select" name="settlementMethod" id="edit_settlementMethod">
					</select>
				</td>
				<td class="inputLabelTd">是否可以提供发票：</td>
				<td class="inputTd">
					<label>
						<input id="edit_proInvoiceFlag" name="proInvoiceFlag" class="ace ace-switch ace-switch-5" type="checkbox" />
						<span class="lbl"></span>
					</label>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">登记人：</td>
				<td class="inputTd">
					<input id="edit_registrant" name="registrant" type="text" class="text" value="${store.registrant}"/>
				</td>
				<td class="inputLabelTd">登记日期：</td>
				<td class="inputTd">
					<div class="input-group">
						<input class="date-picker text" name="registDate" id="edit_registDate" type="text" data-date-format="yyyy-mm-dd" />
						<span>
							<i class="icon-calendar bigger-110"></i>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">运营开始时间：</td>
				<td class="inputTd">
					<div class="input-group">
						<input class="date-picker text" name="operateDate" id="edit_operateDate" type="text" data-date-format="yyyy-mm-dd" />
						<span>
							<i class="icon-calendar bigger-110"></i>
						</span>
					</div>
				</td>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd">
					<input id="edit_remark" name="remark" type="text" class="text" value="${store.remark}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">大概店铺月销售额(万元)：</td>
				<td class="inputTd">
					<input id="edit_averageSales" name="averageSales" type="text" class="text money" value="${store.averageSales}"/>
				</td>
				<td class="inputLabelTd">饿了么平台月销售单量：</td>
				<td class="inputTd">
					<input id="edit_elmSale" name="elmSale" type="text" class="text number" value="${store.elmSale}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">美团平台月销售单量：</td>
				<td class="inputTd">
					<input id="edit_meituanSale" name="meituanSale" type="text" class="text number" value="${store.meituanSale}"/>
				</td>
				<td class="inputLabelTd">百度平台月销售单量：</td>
				<td class="inputTd">
					<input id="edit_baiduSale" name="baiduSale" type="text" class="text number" value="${store.baiduSale}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">饿了么平台佣金率(%)：</td>
				<td class="inputTd">
					<input id="edit_elmRate" name="elmRate" type="text" class="text rate" value="${store.elmRate}"/>
				</td>
				<td class="inputLabelTd">美团平台佣金率(%)：</td>
				<td class="inputTd">
					<input id="edit_meituanRate" name="meituanRate" type="text" class="text rate" value="${store.meituanRate}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">百度平台佣金率(%)：</td>
				<td class="inputTd">
					<input id="edit_baiduRate" name="baiduRate" type="text" class="text rate" value="${store.baiduRate}"/>
				</td>
				<td class="inputLabelTd">关联店铺账号：</td>
				<td class="inputTd">
					<select class="search_select" name="ownerUserId" id="edit_ownerUserId">
						<c:forEach items="${user}" var="user">
							<option value="${user.id}"><c:out value="${user.userAccount}"></c:out></option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">实景图片1：</td>
				<td class="inputTd">
				<form method="post" id="realImageForm" target="realImageIframe" action="<%=request.getContextPath()%>/common/fileUpload" enctype="multipart/form-data">
					<input id="image_storeName" name="image_storeName" type="text" class="text" style="display:none;" value="storeName"/>
					<input id="edit_realImagePath1" name="realImagePath1" type="file" class="text" value="${store.realImagePath1}"/>
					<input id="realImage_submit" type="button" value="上传" class="btn spinner-up btn-xs btn-success upload" >
					<iframe id="realImageIframe1" name="realImageIframe1" onload="checkRealImage('realImageIframe1');" style="display:none;"></iframe>
				</form> 
				</td>
				<td class="inputLabelTd">实景图片2：</td>
				<td class="inputTd">
				<form method="post" id="realImageForm" target="realImageIframe" action="<%=request.getContextPath()%>/common/fileUpload" enctype="multipart/form-data">
					<input id="image_storeName" name="image_storeName" type="text" class="text" style="display:none;" value="storeName"/>
					<input id="edit_realImagePath2" name="realImagePath2" type="file" class="text" value="${store.realImagePath2}"/>
					<input id="realImage_submit" type="button" value="上传" class="btn spinner-up btn-xs btn-success upload" >
					<iframe id="realImageIframe2" name="realImageIframe1" onload="checkRealImage('realImageIframe2');" style="display:none;"></iframe>
				</form> 
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">实景图片3：</td>
				<td class="inputTd">
					<input id="edit_realImagePath3" name="realImagePath3" type="file" class="text" value="${store.realImagePath3}"/>
				</td>
				<td class="inputLabelTd">营业执照：</td>
				<td class="inputTd">
					<input id="edit_businessLicenseImg" name="businessLicenseImg" type="file" class="text" value="${store.businessLicenseImg}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">卫生经营许可证：</td>
				<td class="inputTd">
					<input id="edit_healthLicenseImg" name="healthLicenseImg" type="file" class="text" value="${store.healthLicenseImg}"/>
				</td>
				<td class="inputLabelTd">菜单：</td>
				<td class="inputTd">
					<input id="edit_menuImg" name="menuImg" type="file" class="text" value="${store.menuImg}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">法人身份证（正面）：</td>
				<td class="inputTd">
					<input id="edit_corporateIdcardFront" name="corporateIdcardFront" type="file" class="text" value="${store.corporateIdcardFront}"/>
				</td>
				<td class="inputLabelTd">法人身份证（反面）：</td>
				<td class="inputTd">
					<input id="edit_corporateIdcardBack" name="corporateIdcardBack" type="file" class="text" value="${store.corporateIdcardBack}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">堂食照：</td>
				<td class="inputTd">
					<input id="edit_canteenImg" name="canteenImg" type="file" class="text" value="${store.canteenImg}"/>
				</td>
				<td class="inputLabelTd">后厨照：</td>
				<td class="inputTd">
					<input id="edit_kitchenImg" name="kitchenImg" type="file" class="text" value="${store.kitchenImg}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">门头：</td>
				<td class="inputTd">
					<input id="edit_doorImg" name="doorImg" type="file" class="text" value="${store.doorImg}"/>
				</td>
				<td class="inputLabelTd">法人手持身份证(正）：</td>
				<td class="inputTd">
					<input id="edit_corporateWithidcardFront" name="corporateWithidcardFront" type="file" class="text" value="${store.corporateWithidcardFront}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">法人手持身份证(反)：</td>
				<td class="inputTd">
					<input id="edit_corporateWithidcardBack" name="corporateWithidcardBack" type="file" class="text" value="${store.corporateWithidcardBack}"/>
				</td>
			</tr>
			<tr>
				<td class="inputTd" colspan="4" style="text-align:center;">
					<input id="submit" type="button" class="ti_bottom" value="保存"/>
				</td>
			</tr>
		</table>
    </div>
</body>
</html>
