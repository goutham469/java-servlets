<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Navigation</title>
    <style>
        body {
            margin: 0;
            background-color: #343a40;
            font-family: Arial, sans-serif;
        }
        ul {
            display: flex;
            list-style-type: none;
            padding: 10px 0;
            margin: 0;
            justify-content: center;
            background-color: #343a40;
        }
        li {
            margin: 0 20px;
        }
        a {
            color: #ffffff;
            text-decoration: none;
            font-weight: bold;
            font-size: 16px;
            padding: 8px 12px;
            border-radius: 4px;
            transition: background 0.3s;
        }
        a:hover {
            background-color: #495057;
        }
        body{
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }
    </style>
</head>
<body>
    <img
        src="./assets/logo.png"
        width="200px"
        style="margin: 10px;border-radius: 10px;"
    />
    <ul style="list-style-type: none;">
        <li><a href="./profile.jsp" target="outlet">Profile</a></li>
        <li><a href="./all-questions.jsp" target="outlet">QUESTIONS</a></li>
        <li><a href="./all-answers.jsp" target="outlet">ANSWERS</a></li>
        <li><a href="./new-post.jsp" target="outlet">+ POST</a></li>
    </ul>
</body>
</html>
