<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ocean View Resort | Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <style>
        :root{
            --p1:#6D28D9;
            --p2:#A78BFA;
            --w:#fff;
            --text:rgba(255,255,255,0.92);
            --muted:rgba(255,255,255,0.72);
            --glass:rgba(255,255,255,0.12);
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
            background:
                    radial-gradient(1200px 700px at 15% 10%, rgba(167,139,250,0.35), transparent 55%),
                    radial-gradient(900px 600px at 85% 20%, rgba(109,40,217,0.30), transparent 55%),
                    linear-gradient(120deg, rgba(8,6,20,0.72), rgba(8,6,20,0.35)),
                    url("images/resort-bg.jpg") center/cover no-repeat fixed;
        }
        .page{
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            padding: 28px 16px;
        }
        .wrap{
            width:min(1000px, 100%);
            display:grid;
            grid-template-columns: 1.1fr 0.9fr;
            gap: 16px;
        }
        @media(max-width: 900px){
            .wrap{grid-template-columns: 1fr;}
        }
        .glass{
            background: linear-gradient(180deg, var(--glass), var(--glass2));
            border: 1px solid var(--border);
            border-radius: 22px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            overflow:hidden;
        }
        .left{
            padding: 26px;
            min-height: 420px;
        }
        .brand{
            display:flex; align-items:center; gap:12px;
        }
        .logo{
            width:52px; height:52px; border-radius:16px;
            border: 1px solid rgba(255,255,255,0.25);
            overflow:hidden; background: rgba(255,255,255,0.10);
            display:flex; align-items:center; justify-content:center;
        }
        .logo img{width:100%; height:100%; object-fit:cover;}
        h1{margin:18px 0 10px; font-size:48px; line-height:1.05;}
        p{color: var(--muted); line-height:1.7; margin:0;}
        .tip{margin-top:16px; font-size:13px;}
        .right{padding: 22px;}
        .title{font-size:22px; font-weight:900; margin-bottom:12px;}
        .msg{
            margin-bottom: 12px;
            padding: 10px 12px;
            border-radius: 14px;
            border:1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.08);
            color: rgba(255,255,255,0.92);
        }
        .msg.err{border-color: rgba(255,80,80,0.55); background: rgba(255,0,0,0.12);}
        label{display:block; margin:10px 0 6px; color: rgba(255,255,255,0.85); font-weight:700;}
        input{
            width:100%;
            padding: 14px 14px;
            border-radius: 16px;
            border:1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.10);
            color: white;
            outline:none;
        }
        input:focus{border-color: rgba(167,139,250,0.65);}
        .btn{
            width:100%;
            margin-top: 14px;
            padding: 14px 16px;
            border-radius: 18px;
            border: 0;
            font-weight: 900;
            letter-spacing: .5px;
            color: white;
            background: linear-gradient(135deg, var(--p1), var(--p2));
            cursor:pointer;
        }
        .btn:hover{filter: brightness(1.05);}
        .footer{
            text-align:center;
            color: rgba(255,255,255,0.65);
            margin-top: 14px;
            font-size: 12px;
        }
    </style>
</head>
<body>
<div class="page">
    <div class="wrap">

        <div class="glass left">
            <div class="brand">
                <div class="logo">
                    <img src="images/logo.png" alt="Logo"
                         onerror="this.style.display='none'; this.parentNode.innerHTML='OV'; this.parentNode.style.fontWeight='900';" />
                </div>
                <div>
                    <div style="font-weight:900;font-size:18px;">Ocean View Resort</div>
                    <div style="color:rgba(255,255,255,0.72);font-size:12px;">Hotel Reservation & Billing System</div>
                </div>
            </div>

            <h1>Secure Login</h1>
            <p>Please sign in to access the reservation and billing system.</p>
            <p class="tip">Tip: If you don’t have an account, ask the admin to create one.</p>
        </div>

        <div class="glass right">
            <div class="title">Login to Continue</div>

            <%
                String err = request.getParameter("err");
                String msg = request.getParameter("msg");
                if (err != null) {
            %>
            <div class="msg err"><%= err %></div>
            <%
            } else if (msg != null) {
            %>
            <div class="msg"><%= msg %></div>
            <%
                }
            %>

            <form action="<%=request.getContextPath()%>/login" method="post">
                <label>Username</label>
                <input type="text" name="username" placeholder="admin / reception1 / manager1" required />

                <label>Password</label>
                <input type="password" name="password" placeholder="Enter password" required />

                <button class="btn" type="submit">LOGIN</button>
            </form>

            <div class="footer">© <%= java.time.Year.now() %> Ocean View Resort</div>
        </div>

    </div>
</div>
</body>
</html>