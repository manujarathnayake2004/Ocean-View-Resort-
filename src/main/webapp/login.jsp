<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String msg = request.getParameter("msg");
    if (msg == null) msg = "";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ocean View Resort | Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family:"Segoe UI", Arial, sans-serif;
            min-height:100vh;
            background: url("images/resort-bg.jpg") center/cover no-repeat fixed;
            color:#fff;
        }
        .overlay{
            min-height:100vh;
            background:rgba(0,0,0,0.35);
            display:flex;
            justify-content:center;
            align-items:center;
            padding:20px;
        }
        .container{
            width:min(1100px, 100%);
            display:flex;
            gap:22px;
            flex-wrap:wrap;
        }
        .left, .right{
            flex:1 1 420px;
            background:rgba(255,255,255,0.12);
            border:1px solid rgba(255,255,255,0.22);
            border-radius:28px;
            backdrop-filter:blur(14px);
            -webkit-backdrop-filter:blur(14px);
            box-shadow:0 25px 70px rgba(0,0,0,0.40);
            padding:28px;
        }
        .brand{
            display:flex;
            align-items:center;
            gap:12px;
            margin-bottom:14px;
        }
        .logo{
            width:46px; height:46px;
            border-radius:14px;
            background:rgba(0,0,0,0.35);
            display:flex;
            align-items:center;
            justify-content:center;
            font-weight:900;
        }
        .brand h3{
            margin:0;
            font-size:18px;
        }
        .brand p{
            margin:2px 0 0;
            opacity:0.8;
            font-size:12px;
        }
        .title{
            font-size:46px;
            margin:18px 0 10px;
            font-weight:900;
            letter-spacing:0.5px;
        }
        .desc{
            opacity:0.85;
            line-height:1.6;
            font-size:14px;
            max-width:520px;
        }
        .tip{
            margin-top:18px;
            opacity:0.75;
            font-size:12px;
        }

        .right h2{
            margin:0 0 14px;
            font-size:20px;
            font-weight:900;
        }

        .msg{
            margin-bottom:14px;
            padding:12px 14px;
            border-radius:14px;
            background:rgba(0,0,0,0.35);
            border:1px solid rgba(255,255,255,0.18);
            font-size:13px;
        }

        label{
            display:block;
            font-size:12px;
            opacity:0.8;
            margin:10px 0 6px;
            font-weight:800;
        }
        input{
            width:100%;
            padding:14px 14px;
            border-radius:16px;
            border:none;
            outline:none;
            background:rgba(255,255,255,0.16);
            color:#fff;
            font-weight:700;
        }
        input::placeholder{
            color:rgba(255,255,255,0.6);
        }

        .btn{
            width:100%;
            margin-top:18px;
            padding:14px 16px;
            border:none;
            border-radius:18px;
            cursor:pointer;
            font-size:16px;
            font-weight:900;
            color:#fff;
            background:linear-gradient(135deg,#5B21B6,#A78BFA);
            box-shadow:0 18px 40px rgba(91,33,182,0.30);
        }
        .btn:hover{
            filter:brightness(1.08);
        }
        .footer{
            text-align:center;
            margin-top:16px;
            font-size:12px;
            opacity:0.75;
        }
    </style>
</head>

<body>
<div class="overlay">
    <div class="container">

        <div class="left">
            <div class="brand">
                <div class="logo">OV</div>
                <div>
                    <h3>Ocean View Resort</h3>
                    <p>Hotel Reservation & Billing System</p>
                </div>
            </div>

            <div class="title">Secure Login</div>
            <div class="desc">
                Please sign in to access the reservation and billing system.
                Your customer ID and mobile are protected with unique rules in the database.
            </div>
            <div class="tip">
                Tip: If you don’t have an account, ask the system admin to create one.
            </div>
        </div>

        <div class="right">
            <h2>Login to Continue</h2>

            <% if (!msg.trim().isEmpty()) { %>
            <div class="msg"><%= msg %></div>
            <% } %>

            <!-- ✅ IMPORTANT: Correct action & method -->
            <form action="LoginServlet" method="post">

                <!-- ✅ IMPORTANT: Correct input names -->
                <label>Username</label>
                <input type="text" name="username" placeholder="Enter username" required>

                <label>Password</label>
                <input type="password" name="password" placeholder="Enter password" required>

                <button type="submit" class="btn">LOGIN</button>
            </form>

            <div class="footer">© 2026 Ocean View Resort</div>
        </div>

    </div>
</div>
</body>
</html>