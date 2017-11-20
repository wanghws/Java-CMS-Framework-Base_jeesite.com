<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>Demo</title>
	<meta name="decorator" content="default"/>
</head>
<body>
<br><br><br>
<form class="form-horizontal"  action="/sys/demo/decrypt" method="post" >
	<div class="control-group">
		<label class="control-label">content</label>
		<div class="controls">
			<textarea type="text" name="content"   class="input-xxlarge" rows="10">${content}</textarea>

		</div>
	</div>
	<div class="control-group">
		<label class="control-label">decrypt</label>
		<div class="controls">
			<textarea type="text" name="decrypt"   class="input-xxlarge" rows="10">${result}</textarea>

		</div>
	</div>
	<div class="form-actions">
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</div>
</form>

</body>
</html>