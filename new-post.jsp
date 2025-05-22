<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Post</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e9ecef;
            padding: 40px;
        }

        .form-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            max-width: 500px;
            margin: auto;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        textarea {
            width: 100%;
            height: 150px;
            padding: 10px;
            font-size: 14px;
            border-radius: 5px;
            border: 1px solid #ccc;
            resize: vertical;
            box-sizing: border-box;
        }

        button {
            background-color: #0d6efd;
            color: white;
            padding: 10px 20px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 15px;
        }

        button:hover {
            background-color: #0b5ed7;
        }

        h2 {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Post a New Question</h2>
        <form action="submit-question">
            <textarea placeholder="Your question goes here..." name="question" required></textarea>
            
            <br/>
            <button type="submit">Submit Question</button>
        </form>
    </div>
</body>
</html>
