<%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 24/05/19
  Time: 18:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Form insertar users</title>
</head>
<body>


<form action="insertar.jsp" method="post">
    <label for="name">Nombre:</label>
    <input type="text" name="name" id="name" placeholder="Tony Stark">
    <label for="name">Casa:</label>
    <input type="text" name="casa" id="casa" placeholder="casa stark">
    <input type="submit" value="Enviar">
</form>

</body>
</html>
