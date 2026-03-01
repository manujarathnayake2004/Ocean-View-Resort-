<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user = (String) session.getAttribute("loggedUser");
    String role = (String) session.getAttribute("loggedRole");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Admin only
    if (role == null || !"ADMIN".equalsIgnoreCase(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Ocean View Resort | Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <style>
        :root{
            --p1:#6D28D9;
            --p2:#A78BFA;
            --w:#ffffff;

            --text:rgba(255,255,255,0.92);
            --muted:rgba(255,255,255,0.72);

            --glass:rgba(255,255,255,0.12);
            --glass2:rgba(255,255,255,0.08);
            --border:rgba(255,255,255,0.20);

            --shadow: 0 18px 70px rgba(0,0,0,0.55);
        }

        *{box-sizing:border-box;}
        body{
            margin:0;
            font-family: "Segoe UI", Arial, sans-serif;
            min-height:100vh;
            color: var(--text);

            /* Keep same background brightness like index page */
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
            padding: 26px 16px;
        }

        .wrap{
            width:min(1200px, 100%);
            border-radius: 26px;
            background: linear-gradient(180deg, var(--glass), var(--glass2));
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
            overflow:hidden;
        }

        .topbar{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap: 12px;
            padding: 18px 22px;
            border-bottom: 1px solid rgba(255,255,255,0.10);
        }

        .brand{
            display:flex;
            align-items:center;
            gap:12px;
        }

        .logo{
            width:44px;
            height:44px;
            border-radius: 14px;
            display:flex;
            align-items:center;
            justify-content:center;
            background: rgba(255,255,255,0.10);
            border: 1px solid rgba(255,255,255,0.20);
            font-weight: 900;
            letter-spacing: 0.5px;
        }

        .brand-text b{display:block; font-size:16px;}
        .brand-text span{display:block; font-size:12px; color: var(--muted); margin-top:2px;}

        .who{
            font-size: 12px;
            color: rgba(255,255,255,0.82);
            padding: 8px 12px;
            border-radius: 999px;
            border: 1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.08);
            white-space:nowrap;
        }

        .content{
            padding: 22px;
        }

        .title{
            margin: 6px 0 4px;
            font-size: 44px;
            line-height: 1.05;
            letter-spacing: 0.6px;
            text-shadow: 0 10px 26px rgba(0,0,0,0.35);
        }

        .subtitle{
            margin: 0 0 18px;
            max-width: 820px;
            color: var(--muted);
            font-size: 13px;
            line-height: 1.65;
        }

        .grid{
            display:grid;
            grid-template-columns: 1.1fr 0.9fr;
            gap: 16px;
        }

        @media (max-width: 980px){
            .grid{grid-template-columns:1fr;}
            .title{font-size: 36px;}
        }

        .panel{
            border-radius: 20px;
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.16);
            padding: 16px;
        }

        .panel h3{
            margin: 0 0 12px;
            font-size: 15px;
            letter-spacing: 0.4px;
            color: rgba(255,255,255,0.92);
        }

        .menu{
            display:flex;
            flex-direction:column;
            gap: 10px;
        }

        .item{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap: 12px;
            text-decoration:none;
            color: var(--text);
            padding: 14px 14px;
            border-radius: 16px;
            border: 1px solid rgba(255,255,255,0.14);
            background: rgba(255,255,255,0.08);
            transition: transform .12s ease, background .12s ease, border-color .12s ease;
        }

        .item:hover{
            transform: translateY(-1px);
            background: rgba(255,255,255,0.12);
            border-color: rgba(255,255,255,0.22);
        }

        .left{
            display:flex;
            align-items:center;
            gap: 12px;
        }

        .ic{
            width:40px;
            height:40px;
            border-radius: 14px;
            display:flex;
            align-items:center;
            justify-content:center;
            background: rgba(109,40,217,0.22);
            border: 1px solid rgba(167,139,250,0.22);
            font-size: 18px;
        }

        .txt b{display:block; font-size: 14px;}
        .txt span{display:block; font-size: 12px; color: var(--muted); margin-top:2px;}

        .arrow{
            opacity: 0.8;
            font-weight: 900;
            font-size: 18px;
        }

        .note{
            padding: 12px 12px;
            border-radius: 16px;
            border: 1px solid rgba(255,255,255,0.14);
            background: rgba(255,255,255,0.08);
            margin-bottom: 10px;
        }
        .note b{display:block; font-size: 13px; margin-bottom: 6px;}
        .note p{margin:0; font-size: 12px; color: var(--muted); line-height:1.6;}

        .footer{
            text-align:center;
            padding: 16px 10px 20px;
            color: rgba(255,255,255,0.60);
            font-size: 12px;
        }
    </style>
</head>

<body>
<div class="page">
    <div class="wrap">

        <div class="topbar">
            <div class="brand">
                <div class="logo">OV</div>
                <div class="brand-text">
                    <b>Ocean View Resort</b>
                    <span>Admin Dashboard</span>
                </div>
            </div>

            <div class="who">
                Logged in: <%= user %> (Admin)
            </div>
        </div>

        <div class="content">
            <div class="title">Welcome, <%= user %> 👋</div>
            <div class="subtitle">
                From here you can manage reservations, view details, calculate bills, and access admin-only controls.
                This page keeps the same glass UI style as your index page.
            </div>

            <div class="grid">
                <!-- LEFT: ADMIN FUNCTIONS -->
                <div class="panel">
                    <h3>Admin Functions</h3>

                    <div class="menu">
                        <!-- ✅ Change ONLY href if your file name is different -->
                        <a class="item" href="addReservation.jsp">
                            <div class="left">
                                <div class="ic">➕</div>
                                <div class="txt">
                                    <b>Add New Reservation</b>
                                    <span>Create a new booking entry</span>
                                </div>
                            </div>
                            <div class="arrow">›</div>
                        </a>

                        <a class="item" href="viewReservation.jsp">
                            <div class="left">
                                <div class="ic">🔍</div>
                                <div class="txt">
                                    <b>Display Reservation Details</b>
                                    <span>View a reservation by number</span>
                                </div>
                            </div>
                            <div class="arrow">›</div>
                        </a>

                        <a class="item" href="listReservations.jsp">
                            <div class="left">
                                <div class="ic">📋</div>
                                <div class="txt">
                                    <b>View All Reservations</b>
                                    <span>Open reservation history list</span>
                                </div>
                            </div>
                            <div class="arrow">›</div>
                        </a>

                        <a class="item" href="searchReservation.jsp">
                            <div class="left">
                                <div class="ic">🧾</div>
                                <div class="txt">
                                    <b>Calculate & Print Bill</b>
                                    <span>Search reservation number and print bill</span>
                                </div>
                            </div>
                            <div class="arrow">›</div>
                        </a>

                        <a class="item" href="help.jsp">
                            <div class="left">
                                <div class="ic">❓</div>
                                <div class="txt">
                                    <b>Help</b>
                                    <span>View system guide & instructions</span>
                                </div>
                            </div>
                            <div class="arrow">›</div>
                        </a>

                        <a class="item" href="exit.jsp">
                            <div class="left">
                                <div class="ic">🚪</div>
                                <div class="txt">
                                    <b>Exit System</b>
                                    <span>Exit page / thank you screen</span>
                                </div>
                            </div>
                            <div class="arrow">›</div>
                        </a>

                        <!-- If your logout is a servlet, change to LogoutServlet -->
                        <a class="item" href="logout.jsp">
                            <div class="left">
                                <div class="ic">🔒</div>
                                <div class="txt">
                                    <b>Logout</b>
                                    <span>End the session safely</span>
                                </div>
                            </div>
                            <div class="arrow">›</div>
                        </a>
                    </div>
                </div>

                <!-- RIGHT: QUICK NOTES -->
                <div class="panel">
                    <h3>Quick Notes</h3>

                    <div class="note">
                        <b>🛡️ Role Security</b>
                        <p>
                            Admin pages should load only when <b>loggedRole = ADMIN</b>.
                            If you get access denied, check AuthFilter mappings.
                        </p>
                    </div>

                    <div class="note">
                        <b>🧾 Billing Tip</b>
                        <p>
                            Use <b>Calculate & Print Bill</b> after searching a reservation number.
                            If bill is empty, confirm the reservation exists in the database.
                        </p>
                    </div>

                    <div class="note">
                        <b>📌 Data Quality</b>
                        <p>
                            Keep reservation number, customer ID, and mobile unique to avoid duplicates.
                        </p>
                    </div>

                    <div class="note">
                        <b>✅ Suggestion</b>
                        <p>
                            Add a “User Management” page later for Admin to create Manager/Receptionist accounts.
                        </p>
                    </div>
                </div>
            </div>

            <div class="footer">
                © <%= java.time.Year.now() %> Ocean View Resort • Admin Panel
            </div>
        </div>
    </div>
</div>
</body>
</html>