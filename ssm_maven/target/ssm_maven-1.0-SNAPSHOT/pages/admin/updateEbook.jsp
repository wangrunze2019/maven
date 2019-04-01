<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() +request.getContextPath()+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath %>">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>删除贴子</title>
    <script src="<%=basePath%>/static/js/bootstrap/jquery.min.js"></script>
    <script src="<%=basePath%>/static/js/JsonHandler.js"></script>
</head>
<body>
<center>
    <form action="javascript:void(0)" id="form1">
        <table width="600px" width="400px" border="1px" cellspacing="0px">
            <tr>
                <td colspan="2"  align="center"><h3>更新电子图书</h3></td>
            </tr>
            <tr>
                <input type="hidden" name="catgoryId" value="${sessionScope.ebook.catgoryId}">
                <td>帖子名称(*)：</td>
                <td><input type="text" name="title" value="${sessionScope.ebook.title}"></td>
            </tr>
            <tr>
                <td>帖子摘要：</td>
                <td>
                    <textarea name="summary" cols="50" rows="5">${sessionScope.ebook.summary}</textarea>
                </td>
            </tr>
            <tr>
                <td>上传人：</td>
                <td><input type="text" name="uploaduser" value="${sessionScope.ebook.uploaduser}"></td>
            </tr>
            <tr>
                <td>上传时间：</td>
                <td>
                    <input type="text" name="createdate" value="${sessionScope.ebook.createdate}">yyyy-MM-dd
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="修改">
                    &nbsp;&nbsp;
                    <input type="reset" value="重置">
                </td>
            </tr>
        </table>
    </form>
</center>

<script type="text/javascript">

</script>

</body>
</html>
