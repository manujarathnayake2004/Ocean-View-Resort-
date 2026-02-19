<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Ocean View Resort | Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <style>
        :root{
            --p1:#6D28D9;   /* purple */
            --p2:#A78BFA;   /* light purple */
            --w:#FFFFFF;

            --text:rgba(255,255,255,0.92);
            --muted:rgba(255,255,255,0.72);

            --glass:rgba(255,255,255,0.13);
            --glass2:rgba(255,255,255,0.08);
            --border:rgba(255,255,255,0.22);

            --shadow: 0 18px 70px rgba(0,0,0,0.55);
        }

        *{box-sizing:border-box;}
        body{
            margin:0;
            font-family: "Segoe UI", Arial, sans-serif;
            min-height:100vh;
            color: var(--text);

            /* Bright Luxury Background */
            background:
                    radial-gradient(1000px 600px at 20% 10%, rgba(167,139,250,0.25), transparent 60%),
                    radial-gradient(900px 600px at 80% 20%, rgba(109,40,217,0.18), transparent 60%),
                    linear-gradient(120deg, rgba(255,255,255,0.55), rgba(255,255,255,0.35)),
                    url("images/resort-bg.jpg") center/cover no-repeat fixed;
        }

        .page{
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            padding: 36px 16px;
        }

        .glass{
            width: min(980px, 100%);
            display:grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 18px;

            background: linear-gradient(180deg, var(--glass), var(--glass2));
            border: 1px solid var(--border);
            border-radius: 26px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            overflow:hidden;
        }

        @media (max-width: 900px){
            .glass{grid-template-columns:1fr;}
        }

        /* LEFT INFO */
        .left{
            padding: 28px;
            position:relative;
            overflow:hidden;
        }
        .left::before{
            content:"";
            position:absolute;
            inset:-80px;
            background:
                    radial-gradient(circle at 20% 15%, rgba(167,139,250,0.30), transparent 60%),
                    radial-gradient(circle at 80% 70%, rgba(109,40,217,0.28), transparent 62%);
            pointer-events:none;
        }
        .left-inner{position:relative;}

        .brand{
            display:flex;
            align-items:center;
            gap: 12px;
            margin-bottom: 18px;
        }
        .logo{
            width:52px; height:52px;
            border-radius:16px;
            border:1px solid rgba(255,255,255,0.25);
            overflow:hidden;
            background: rgba(255,255,255,0.10);
            display:flex;
            align-items:center;
            justify-content:center;
            font-weight:900;
            box-shadow: 0 10px 30px rgba(0,0,0,0.35);
        }
        .logo img{width:100%; height:100%; object-fit:cover;}

        .brand-text b{display:block; font-size:18px; letter-spacing:0.3px;}
        .brand-text span{display:block; margin-top:2px; font-size:12px; color:var(--muted);}

        h1{
            margin: 22px 0 10px;
            font-size: 40px;
            line-height: 1.05;
            letter-spacing: 0.6px;
            text-shadow: 0 10px 26px rgba(0,0,0,0.35);
        }

        .sub{
            margin:0;
            color: var(--muted);
            font-size: 14px;
            line-height: 1.7;
            max-width: 520px;
        }

        .hint{
            margin-top: 16px;
            font-size: 12px;
            color: rgba(255,255,255,0.65);
        }

        /* RIGHT FORM */
        .right{
            padding: 22px;
            display:flex;
            align-items:center;
            justify-content:center;
        }

        .form-card{
            width:100%;
            max-width: 380px;
            border-radius: 22px;
            border: 1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.08);
            padding: 18px;
            position:relative;
            overflow:hidden;
        }
        .form-card::before{
            content:"";
            position:absolute;
            inset:-60px;
            background: radial-gradient(circle at 25% 20%, rgba(167,139,250,0.20), transparent 55%);
            pointer-events:none;
        }
        .form-inner{position:relative;}

        .form-title{
            font-size: 16px;
            font-weight: 900;
            letter-spacing: 0.4px;
            margin: 4px 0 12px;
        }

        label{
            display:block;
            margin: 10px 0 6px;
            font-size: 12px;
            color: rgba(255,255,255,0.75);
            letter-spacing:0.2px;
        }

        input{
            width:100%;
            padding: 12px 12px;
            border-radius: 14px;
            border: 1px solid rgba(255,255,255,0.22);
            background: rgba(10,8,22,0.35);
            color: var(--w);
            outline:none;
        }
        input::placeholder{color: rgba(255,255,255,0.45);}
        input:focus{
            border-color: rgba(167,139,250,0.70);
            box-shadow: 0 0 0 3px rgba(167,139,250,0.20);
        }

        .btn{
            width:100%;
            margin-top: 14px;
            padding: 12px 14px;
            border-radius: 14px;
            border: 1px solid rgba(255,255,255,0.22);
            font-weight: 900;
            letter-spacing: 0.3px;
            cursor:pointer;
            color: var(--w);
            background: linear-gradient(135deg, var(--p1), var(--p2));
            box-shadow: 0 14px 34px rgba(109,40,217,0.35);
            transition: transform .12s ease, filter .12s ease;
        }
        .btn:hover{transform: translateY(-1px); filter: brightness(1.06);}

        .msg{
            margin-top: 10px;
            font-size: 13px;
            padding: 10px 12px;
            border-radius: 14px;
            border: 1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.10);
        }
        .msg.err{border-color: rgba(255,80,80,0.35); background: rgba(255,80,80,0.12);}
        .msg.ok{border-color: rgba(80,255,160,0.30); background: rgba(80,255,160,0.10);}

        .footer{
            margin-top: 18px;
            text-align:center;
            font-size: 12px;
            color: rgba(255,255,255,0.60);
        }
    </style>
</head>

<body>
<div class="page">

    <div class="glass">

        <!-- LEFT -->
        <div class="left">
            <div class="left-inner">
                <div class="brand">
                    <div class="logo">
                        <img src="images/logo.png" alt="Logo"
                             onerror="this.style.display='none'; this.parentNode.innerHTML='OV';" />
                    </div>
                    <div class="brand-text">
                        <b>Ocean View Resort</b>
                        <span>Hotel Reservation & Billing System</span>
                    </div>
                </div>

                <h1>Secure Login</h1>
                <p class="sub">
                    Please sign in to access the reservation and billing system.
                    Your customer ID and mobile are protected with unique rules in the database.
                </p>

                <div class="hint">
                    Tip: If you don’t have an account, ask the system admin to create one.
                </div>
            </div>
        </div>

        <!-- RIGHT -->
        <div class="right">
            <div class="form-card">
                <div class="form-inner">
                    <div class="form-title">Login to Continue</div>

                    <%
                        String msg = request.getParameter("msg");
                        String err = request.getParameter("err");
                        if (msg != null) {
                    %>
                    <div class="msg ok"><%= msg %></div>
                    <% } %>

                    <%
                        if (err != null) {
                    %>
                    <div class="msg err"><%= err %></div>
                    <% } %>

                    <!-- Change action to your login servlet mapping -->
                    <form action="<%=request.getContextPath()%>/login" method="post">
                        <label>Username</label>
                        <input type="text" name="username" required placeholder="Enter username">

                        <label>Password</label>
                        <input type="password" name="password" required placeholder="Enter password">

                        <button class="btn" type="submit">LOGIN</button>
                    </form>

                    <div class="footer">
                        © <%= java.time.Year.now() %> Ocean View Resort
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>
</body>
</html>