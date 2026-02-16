<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.invalidate(); // destroy session when exiting
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Exit System | Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <style>
        /* SAME Bright Background (Do NOT change brightness) */
        :root{
            --p1:#6D28D9;
            --p2:#A78BFA;

            --text:rgba(255,255,255,0.95);
            --muted:rgba(255,255,255,0.75);

            --glass:rgba(255,255,255,0.10);
            --glass2:rgba(255,255,255,0.06);
            --border:rgba(255,255,255,0.18);
            --shadow:0 18px 70px rgba(0,0,0,0.55);
        }

        *{ box-sizing:border-box; }

        body{
            margin:0;
            font-family:"Segoe UI", Arial, sans-serif;
            min-height:100vh;
            color:var(--text);

            /* SAME background brightness as index */
            background:
                    radial-gradient(1200px 700px at 15% 10%, rgba(196,181,253,0.55), transparent 55%),
                    radial-gradient(900px 600px at 85% 20%, rgba(167,139,250,0.45), transparent 55%),
                    linear-gradient(120deg, rgba(255,255,255,0.55), rgba(255,255,255,0.25)),
                    url("images/resort-bg.jpg") center/cover no-repeat fixed;
        }

        .page{
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            padding:40px 16px;
        }

        .glass{
            width:min(700px, 100%);
            border-radius:22px;
            background:linear-gradient(180deg, var(--glass), var(--glass2));
            border:1px solid var(--border);
            box-shadow:var(--shadow);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            padding:40px 26px;
            text-align:center;
        }

        h1{
            margin:0;
            font-size:28px;
            font-weight:900;
        }

        .sub{
            margin-top:12px;
            font-size:14px;
            color:var(--muted);
            line-height:1.6;
        }

        .icon{
            font-size:52px;
            margin-bottom:18px;
        }

        .actions{
            margin-top:26px;
            display:flex;
            justify-content:center;
            gap:14px;
            flex-wrap:wrap;
        }

        .btn{
            text-decoration:none;
            padding:12px 20px;
            border-radius:14px;
            font-weight:900;
            letter-spacing:0.2px;
            transition:all .2s ease;
            display:inline-flex;
            align-items:center;
            gap:8px;
        }

        .btn-primary{
            background:linear-gradient(135deg, var(--p1), var(--p2));
            color:white;
            box-shadow:0 14px 34px rgba(109,40,217,0.35);
        }
        .btn-primary:hover{
            transform:translateY(-2px);
            filter:brightness(1.05);
        }

        .btn-outline{
            border:1px solid rgba(255,255,255,0.25);
            background:rgba(255,255,255,0.08);
            color:white;
        }
        .btn-outline:hover{
            transform:translateY(-2px);
            background:rgba(255,255,255,0.14);
        }

        .footer{
            margin-top:30px;
            font-size:12px;
            color:rgba(255,255,255,0.65);
        }
    </style>
</head>

<body>
<div class="page">
    <div class="glass">

        <div class="icon">👋</div>

        <h1>You Have Exited the System</h1>

        <p class="sub">
            Thank you for using the Ocean View Resort Reservation & Billing System.
            Your session has been safely closed.
        </p>

        <div class="actions">
            <a class="btn btn-primary" href="login.jsp">🔐 Login Again</a>
            <a class="btn btn-outline" href="index.jsp">🏠 Home</a>
        </div>

        <div class="footer">
            © <%= java.time.Year.now() %> Ocean View Resort | Developed by Manuja Rathnayake
        </div>

    </div>
</div>
</body>
</html>