<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>Demo</title>
	<meta name="decorator" content="default"/>
</head>
<body>
<br><br><br>
<form class="form-horizontal"  action="/sys/demo/query" method="post" >
	<c:if test="${!empty api}">
	<div class="control-group">
		<label class="control-label"></label>
		<div class="controls">
			<a href="/api/v1${url}?params=${api}" target="_blank">${url}</a>
		</div>
	</div>
	</c:if>
	<div class="control-group">
		<label class="control-label">URL</label>
		<div class="controls">
			<input type="text" name="url"  value="${url}" size="100" class="input-xlarge">

		</div>
	</div>
	<div class="control-group">
		<label class="control-label">token</label>
		<div class="controls">
			<input type="text" name="token"  value="${token}" size="100" class="input-xxlarge">

		</div>
	</div>
	<div class="control-group">
		<label class="control-label">customer.id</label>
		<div class="controls">
			<input type="text" name="customerId"  value="${customerId}" size="100" class="input-xlarge">
			<input type="text" name="customerToken"  value="${customerToken}" size="100" class="input-xxlarge">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">employee.id</label>
		<div class="controls">
			<input type="text" name="employeeId" value="${employeeId}" size="100" class="input-xlarge">
			<input type="text" name="employeeToken"  value="${employeeToken}" size="100" class="input-xxlarge">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">dispatch.id</label>
		<div class="controls">
			<input type="text" name="dispatchId" value="${dispatchId}" size="100" class="input-xlarge">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">startTime</label>
		<div class="controls">
			<input type="text" name="startTime" value="${startTime}" size="100" class="input-xlarge Wdate " readonly="readonly"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});">
		</div>
	</div>
	<div class="form-actions">
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</div>
</form>

</body>
</html>