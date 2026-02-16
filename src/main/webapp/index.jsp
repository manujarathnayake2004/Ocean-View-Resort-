<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Optional redirect if already logged in
    // String user = (String) session.getAttribute("loggedUser");
    // if (user != null) { response.sendRedirect("dashboard.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Ocean View Resort | Welcome</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <style>
        :root{
            /* Purple + White theme */
            --p1:#6D28D9;
            --p2:#A78BFA;
            --w:#FFFFFF;

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

            /* Brighter Luxury Background */
            background:
                    radial-gradient(1000px 600px at 20% 15%, rgba(167,139,250,0.45), transparent 55%),
                    radial-gradient(900px 600px at 80% 25%, rgba(109,40,217,0.35), transparent 55%),
                    linear-gradient(120deg, rgba(255,255,255,0.15), rgba(255,255,255,0.05)),
                    url("images/resort-bg.jpg") center/cover no-repeat fixed;

            background-blend-mode: screen, screen, lighten, normal;
        }

        .page{
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            padding: 28px 16px;
        }

        /* Glass panels */
        .glass{
            background: linear-gradient(180deg, var(--glass), var(--glass2));
            border: 1px solid var(--border);
            border-radius: 22px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
        }

        /* Layout like sketch: top big card + 4 small cards under it */
        .wrap{
            width: min(1100px, 100%);
            display:flex;
            flex-direction:column;
            gap: 18px;
        }

        .hero{
            position:relative;
            overflow:hidden;
            padding: 34px 26px 26px;
            text-align:center;
        }

        .hero::before{
            content:"";
            position:absolute;
            inset:-80px;
            background:
                    radial-gradient(circle at 18% 10%, rgba(167,139,250,0.30), transparent 60%),
                    radial-gradient(circle at 82% 80%, rgba(109,40,217,0.26), transparent 62%);
            pointer-events:none;
        }

        .hero-inner{position:relative;}

        /* logo circle near top (like sketch) */
        .logoWrap{
            display:flex;
            justify-content:center;
            margin-bottom: 12px;
        }
        .logo{
            width:64px;
            height:64px;
            border-radius: 18px;
            border: 1px solid rgba(255,255,255,0.25);
            background: rgba(255,255,255,0.10);
            box-shadow: 0 10px 30px rgba(0,0,0,0.35);
            overflow:hidden;
            display:flex;
            align-items:center;
            justify-content:center;
            font-weight:900;
            letter-spacing:0.5px;
        }
        .logo img{width:100%; height:100%; object-fit:cover;}

        h1{
            margin: 8px 0 10px;
            font-size: 42px;
            line-height: 1.1;
            letter-spacing: 0.6px;
            text-shadow: 0 10px 26px rgba(0,0,0,0.35);
        }

        .sub{
            margin: 0 auto;
            max-width: 720px;
            color: var(--muted);
            font-size: 14px;
            line-height: 1.7;
        }

        /* ONLY LOGIN BUTTON */
        .cta{
            margin-top: 18px;
            display:flex;
            justify-content:center;
        }
        .btnLogin{
            text-decoration:none;
            padding: 12px 26px;
            border-radius: 999px;
            font-weight: 900;
            letter-spacing: 0.35px;
            color: var(--w);
            border: 1px solid rgba(255,255,255,0.22);
            background: linear-gradient(135deg, var(--p1), var(--p2));
            box-shadow: 0 14px 34px rgba(109,40,217,0.35);
            transition: transform .12s ease, filter .12s ease;
            display:inline-flex;
            align-items:center;
            gap: 10px;
        }
        .btnLogin:hover{transform: translateY(-1px); filter: brightness(1.06);}

        /* Cards row under hero (must be under footer area like sketch) */
        .cardsRow{
            display:grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
        }
        @media (max-width: 980px){
            .cardsRow{grid-template-columns: repeat(2, 1fr);}
        }
        @media (max-width: 520px){
            .cardsRow{grid-template-columns: 1fr;}
            h1{font-size: 34px;}
        }

        .card{
            position:relative;
            overflow:hidden;
            padding: 16px 16px 14px;
            min-height: 170px;
            border-radius: 22px;
            border: 1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.08);
        }

        .card::before{
            content:"";
            position:absolute;
            inset:-70px;
            background: radial-gradient(circle at 20% 20%, rgba(167,139,250,0.20), transparent 55%);
            pointer-events:none;
        }

        .card h3{
            position:relative;
            margin:0 0 8px;
            font-size: 15px;
            letter-spacing: 0.3px;
        }
        .card p{
            position:relative;
            margin:0;
            font-size: 13px;
            line-height: 1.55;
            color: var(--muted);
        }
        .tag{
            position:relative;
            display:inline-block;
            margin-top: 10px;
            padding: 6px 10px;
            border-radius: 999px;
            border: 1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.08);
            color: rgba(255,255,255,0.85);
            font-size: 12px;
            font-weight: 700;
        }

        /* Footer bar (like sketch) */
        .footerBar{
            margin-top: 60px;
            text-align:center;
            padding: 12px 10px;
            border-radius: 18px;
            border: 1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.08);
            color: rgba(255, 255, 255, 0.7);
            font-size: 12px;
        }
        .footerBar b{color: rgba(255,255,255,0.92);}
    </style>
</head>

<body>
<div class="page">
    <div class="wrap">

        <!-- TOP BIG CARD (Sketch style) -->
        <div class="glass hero">
            <div class="hero-inner">

                <div class="logoWrap">
                    <div class="logo">
                        <img src="images/logo.png" alt="Ocean View Resort Logo"
                             onerror="this.style.display='none'; this.parentNode.innerHTML='OV';" />
                    </div>
                </div>

                <h1>Welcome to Ocean View Resort</h1>
                <p class="sub">
                    Manage customer details, reservations, billing, and receipts in one luxury-styled system.
                    Use the login button to access the application.
                </p>

                <div class="cta">
                    <a class="btnLogin" href="login.jsp">🔐 Login</a>
                </div>

            </div>
        </div>

        <!-- 4 CARDS UNDER (Vision / Mission + 2 others) -->
        <div class="cardsRow">

            <div class="glass card">
                <h3>🌟 Vision</h3>
                <p>
                    To deliver a smooth and premium guest experience by managing reservations and billing
                    with accuracy, speed, and a modern interface.
                </p>
                <span class="tag">Luxury Experience</span>
            </div>

            <div class="glass card">
                <h3>🎯 Mission</h3>
                <p>
                    To simplify daily resort operations by providing a secure system for customer details,
                    reservations, and billing—reducing errors and saving time.
                </p>
                <span class="tag">Smart Operations</span>
            </div>

            <div class="glass card">
                <h3>🔒 Security</h3>
                <p>
                    Session-based access and unique customer ID/mobile validation help keep records clean,
                    reliable, and protected for staff usage.
                </p>
                <span class="tag">Secure Access</span>
            </div>

            <div class="glass card">
                <h3>⚡ Fast Workflow</h3>
                <p>
                    Quickly add, edit, search, and generate bills. Designed for smooth operation during
                    busy reception hours.
                </p>
                <span class="tag">Quick & Easy</span>
            </div>

        </div>

        <!-- FOOTER -->
        <div class="footerBar">
            <div>© <%= java.time.Year.now() %> <b>Ocean View Resort</b> | Hotel Reservation & Billing System</div>
            <div>Developed by <b>Manuja Rathnayake</b></div>
        </div>

    </div>
</div>
</body>
</html>