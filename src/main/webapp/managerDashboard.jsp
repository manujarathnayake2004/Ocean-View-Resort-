<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Session check (Manager only)
    String user = (String) session.getAttribute("loggedUser");
    String role = (String) session.getAttribute("loggedRole");

    if (user == null) {
        response.sendRedirect("login.jsp?msg=Please+login+first");
        return;
    }
    if (role == null || !role.equalsIgnoreCase("MANAGER")) {
        response.sendRedirect("login.jsp?msg=Access+Denied");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Manager Dashboard | Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <style>
        :root{
            --p1:#6D28D9;
            --p2:#A78BFA;
            --w:#FFFFFF;

            --text: rgba(255,255,255,0.92);
            --muted: rgba(255,255,255,0.72);

            --glass: rgba(255,255,255,0.12);
            --glass2: rgba(255,255,255,0.08);
            --border: rgba(255,255,255,0.20);
            --shadow: 0 18px 70px rgba(0,0,0,0.55);
        }

        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family: "Segoe UI", Arial, sans-serif;
            min-height:100vh;
            color: var(--text);

            /* SAME background style as index (do not change brightness) */
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
            padding: 34px 16px;
        }

        .glass{
            width: min(1100px, 100%);
            background: linear-gradient(180deg, var(--glass), var(--glass2));
            border: 1px solid var(--border);
            border-radius: 26px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
            overflow:hidden;
        }

        .top{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap: 14px;
            padding: 22px 22px 14px;
            border-bottom: 1px solid rgba(255,255,255,0.10);
        }

        .brand{
            display:flex;
            align-items:center;
            gap: 12px;
        }

        .logo{
            width:48px;
            height:48px;
            border-radius: 16px;
            background: rgba(255,255,255,0.10);
            border: 1px solid rgba(255,255,255,0.18);
            display:flex;
            align-items:center;
            justify-content:center;
            font-weight: 900;
        }

        .brand b{
            display:block;
            font-size: 16px;
            letter-spacing: 0.2px;
        }
        .brand span{
            display:block;
            font-size: 12px;
            color: var(--muted);
            margin-top: 2px;
        }

        .pill{
            font-size: 12px;
            padding: 8px 12px;
            border-radius: 999px;
            border: 1px solid rgba(255,255,255,0.20);
            background: rgba(255,255,255,0.08);
            color: rgba(255,255,255,0.86);
            white-space:nowrap;
        }

        .content{
            padding: 18px 22px 22px;
        }

        .title{
            display:flex;
            flex-wrap:wrap;
            align-items:flex-end;
            justify-content:space-between;
            gap: 10px;
            margin-bottom: 14px;
        }

        h1{
            margin:0;
            font-size: 34px;
            letter-spacing: 0.3px;
            text-shadow: 0 10px 26px rgba(0,0,0,0.35);
        }

        .subtitle{
            color: var(--muted);
            margin-top: 6px;
            font-size: 13px;
            line-height: 1.6;
            max-width: 720px;
        }

        .grid{
            display:grid;
            grid-template-columns: 1.4fr 1fr;
            gap: 14px;
            margin-top: 16px;
        }

        @media(max-width: 920px){
            .grid{ grid-template-columns: 1fr; }
        }

        .panel{
            border-radius: 20px;
            border: 1px solid rgba(255,255,255,0.14);
            background: rgba(255,255,255,0.08);
            padding: 16px;
            position:relative;
            overflow:hidden;
        }

        .panel::before{
            content:"";
            position:absolute;
            inset:-60px;
            background: radial-gradient(circle at 18% 20%, rgba(167,139,250,0.20), transparent 60%);
            pointer-events:none;
        }

        .panel h2{
            position:relative;
            margin:0 0 10px;
            font-size: 16px;
            letter-spacing: 0.3px;
        }

        .actions{
            position:relative;
            display:grid;
            gap: 10px;
        }

        .action{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap: 12px;
            text-decoration:none;
            color: var(--text);
            padding: 14px 14px;
            border-radius: 16px;
            border: 1px solid rgba(255,255,255,0.16);
            background: rgba(255,255,255,0.08);
            transition: transform .12s ease, background .12s ease, filter .12s ease;
        }
        .action:hover{
            transform: translateY(-1px);
            background: rgba(255,255,255,0.12);
            filter: brightness(1.04);
        }

        .left{
            display:flex;
            align-items:center;
            gap: 12px;
            min-width: 0;
        }
        .ico{
            width: 36px;
            height: 36px;
            border-radius: 12px;
            display:flex;
            align-items:center;
            justify-content:center;
            background: rgba(109,40,217,0.20);
            border: 1px solid rgba(255,255,255,0.16);
            flex: 0 0 auto;
        }
        .txt b{
            display:block;
            font-size: 14px;
            white-space:nowrap;
            overflow:hidden;
            text-overflow:ellipsis;
        }
        .txt span{
            display:block;
            font-size: 12px;
            color: var(--muted);
            margin-top: 2px;
        }

        .arrow{
            font-size: 18px;
            opacity: 0.8;
        }

        .primary{
            background: linear-gradient(135deg, rgba(109,40,217,0.92), rgba(167,139,250,0.72));
            border: 1px solid rgba(255,255,255,0.20);
        }

        .miniStats{
            position:relative;
            display:grid;
            gap: 12px;
        }

        .stat{
            border-radius: 18px;
            padding: 14px;
            border: 1px solid rgba(255,255,255,0.14);
            background: rgba(255,255,255,0.07);
        }
        .stat b{
            display:block;
            font-size: 13px;
            letter-spacing:0.2px;
            margin-bottom: 6px;
        }
        .stat p{
            margin:0;
            color: var(--muted);
            font-size: 12.5px;
            line-height: 1.6;
        }

        .footer{
            padding: 14px 18px;
            text-align:center;
            color: rgba(255,255,255,0.60);
            font-size: 12px;
            border-top: 1px solid rgba(255,255,255,0.10);
        }
    </style>
</head>

<body>
<div class="page">
    <div class="glass">

        <div class="top">
            <div class="brand">
                <div class="logo">OV</div>
                <div>
                    <b>Ocean View Resort</b>
                    <span>Manager Dashboard</span>
                </div>
            </div>

            <div class="pill">
                Logged in: <b><%= user %></b> (Manager)
            </div>
        </div>

        <div class="content">
            <div class="title">
                <div>
                    <h1>Welcome, <%= user %> 👋</h1>
                    <div class="subtitle">
                        From here you can review reservations, monitor transactions, and generate manager reports.
                        This dashboard is limited to manager features only.
                    </div>
                </div>
            </div>

            <div class="grid">

                <!-- Main actions -->
                <div class="panel">
                    <h2>Manager Functions</h2>

                    <div class="actions">
                        <a class="action primary" href="<%=request.getContextPath()%>/listReservations">
                            <div class="left">
                                <div class="ico">📋</div>
                                <div class="txt">
                                    <b>View All Reservations</b>
                                    <span>See all booking records and guest details</span>
                                </div>
                            </div>
                            <div class="arrow">›</div>
                        </a>

                        <a class="action" href="<%=request.getContextPath()%>/report.jsp">
                            <div class="left">
                                <div class="ico">📈</div>
                                <div class="txt">
                                    <b>Generate Reports</b>
                                    <span>View payments & totals (transactions)</span>
                                </div>
                            </div>
                            <div class="arrow">›</div>
                        </a>

                        <a class="action" href="<%=request.getContextPath()%>/logout">
                            <div class="left">
                                <div class="ico">🚪</div>
                                <div class="txt">
                                    <b>Logout</b>
                                    <span>End the session safely</span>
                                </div>
                            </div>
                            <div class="arrow">›</div>
                        </a>
                    </div>
                </div>

                <!-- Side info -->
                <div class="panel">
                    <h2>Quick Notes</h2>

                    <div class="miniStats">
                        <div class="stat">
                            <b>🔒 Role Security</b>
                            <p>Manager pages should be accessible only when <code>loggedRole = MANAGER</code> in session.</p>
                        </div>

                        <div class="stat">
                            <b>💳 Transactions</b>
                            <p>Use <b>Generate Reports</b> to review saved payments and totals for business tracking.</p>
                        </div>

                        <div class="stat">
                            <b>✅ Tip</b>
                            <p>If a page shows “Access Denied”, confirm your AuthFilter rules and role redirect in LoginServlet.</p>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div class="footer">
            © <%= java.time.Year.now() %> Ocean View Resort • Manager Panel
        </div>

    </div>
</div>
</body>
</html>