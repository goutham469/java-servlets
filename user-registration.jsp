<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>
    <style>
        body {
            font-family: sans-serif;
            background-color: #f9f9f9;
            padding: 20px;
        }

        form {
            background-color: bisque;
            border-radius: 5px;
            width: fit-content;
            padding: 10px 20px;
        }

        input {
            margin: 5px 0;
            padding: 5px;
            width: 200px;
        }

        input[type="submit"] {
            width: 100%;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>User Registration</h1>
    <form action="user-register">
        <input type="text" placeholder="username" name="username" /><br/>
        <input type="text" placeholder="password" name="password" /><br/>
        <input type="submit" />
    </form>
</body>
</html>
