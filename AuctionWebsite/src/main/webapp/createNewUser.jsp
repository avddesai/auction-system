<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<script>
  function checkForm(form)
  {
    if(form.usr.value == "") {
      alert("Error: Username cannot be blank!");
      form.usr.focus();
      return false;
    }
    re = /^\w+$/;
    if(!re.test(form.usr.value)) {
      alert("Error: Username must contain only letters, numbers and underscores!");
      form.usr.focus();
      return false;
    }

    if(form.pwd1.value != "" && form.pwd1.value == form.pwd2.value) {
      if(form.pwd1.value.length < 6) {
        alert("Error: Password must contain at least six characters!");
        form.pwd1.focus();
        return false;
      }
      if(form.pwd1.value == form.usr.value) {
        alert("Error: Password must be different from Username!");
        form.pwd1.focus();
        return false;
      }
      re = /[0-9]/;
      if(!re.test(form.pwd1.value)) {
        alert("Error: password must contain at least one number (0-9)!");
        form.pwd1.focus();
        return false;
      }
      re = /[a-z]/;
      if(!re.test(form.pwd1.value)) {
        alert("Error: password must contain at least one lowercase letter (a-z)!");
        form.pwd1.focus();
        return false;
      }
      re = /[A-Z]/;
      if(!re.test(form.pwd1.value)) {
        alert("Error: password must contain at least one uppercase letter (A-Z)!");
        form.pwd1.focus();
        return false;
      }
    } else {
      alert("Error: Please check that you've entered and confirmed your password!");
      form.pwd1.focus();
      return false;
    }

    //alert("You entered a valid password: " + form.pwd1.value);
    return true;
  }
</script>
<body><h2>Register</h2>
 <form action="register.jsp" method="post" onsubmit="return checkForm(this);">Username<input type="text" name="usr" /><br>${existingUser}<br>Name<input type = "text" name ="name" /><br>Password<input type="password" name="pwd1" /><br>Confirm Password<input type="password" name="pwd2" /><br> E-mail ID<input type="text" name="email" /><br> <br> <input type="submit"/><br><a href = "index.jsp">Login</a><br>
 </form>
</body>
</html>