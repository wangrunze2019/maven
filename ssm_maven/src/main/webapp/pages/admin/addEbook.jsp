<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() +request.getContextPath()+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath %>">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>新增电子图书</title>
    <script src="<%=basePath%>/static/js/bootstrap/jquery.min.js"></script>
    <script src="<%=basePath%>/static/js/JsonHandler.js"></script>
</head>
<body>
<center>
    <form action="javascript:void(0)" id="form1">
        <table width="600px" width="400px" border="1px" cellspacing="0px">
            <tr>
                <td colspan="2"  align="center"><h3>新增帖子</h3></td>
            </tr>
            <tr>
                <input type="hidden" name="catgoryId" value="${param.catgoryId}">
                <td>标题名称(*)：</td>
                <td><input type="text" name="title"></td>
            </tr>
            <tr>
                <td>帖子摘要：</td>
                <td>
                    <textarea name="summary" cols="50" rows="5"></textarea>
                </td>
            </tr>
            <tr>
                <td>上传人：</td>
                <td><input type="text" name="uploaduser"></td>
            </tr>
            <tr>
                <td>上传时间：</td>
                <td>
                    <input type="text" name="createdate">yyyy-MM-dd
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="提交">
                    &nbsp;&nbsp;
                    <input type="button" value="返回">
                </td>
            </tr>
        </table>
    </form>
</center>

<script type="text/javascript">
    $(function(){
        $("input[type=submit]").click(function(){
            //校验电子书名称是否为""
            var name = $("input[name=title]").val();
            if(name==""){
                window.alert("图书名称不能为空");
            }else {
                //将id=form1标签下的所有表单数据构建成JSON类型
                var jsonStr = JSON.stringify($("#form1").serializeObject());
                $.ajax({
                    url: "<%=basePath %>/book/addEbook.do",
                    type: "POST",
                    dataType: "JSON",
                    data: jsonStr,
                    contentType: "application/json",
                    success: function (rs) {
                        if (rs) {
                            //关闭当前页面
                            window.close();
                            //需要刷新ebookList.jsp
                            window.opener.location.reload();
                        } else {
                            window.alert("添加失败，请重试");
                        }
                    }
                });
            }
        });
    });
</script>

</body>
</html>
