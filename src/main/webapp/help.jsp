<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user = (String) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp?msg=Please+login+first");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Help | Ocean View Resort</title>
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

            /* SAME bright background used in your index */
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

        .wrap{
            width:min(1100px, 100%);
            display:grid;
            grid-template-columns: 1.4fr 1fr;
            gap:18px;
        }

        @media (max-width: 980px){
            .wrap{ grid-template-columns: 1fr; }
        }

        .glass{
            border-radius:22px;
            background:linear-gradient(180deg, var(--glass), var(--glass2));
            border:1px solid var(--border);
            box-shadow:var(--shadow);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
        }

        /* LEFT MAIN HELP PANEL */
        .main{
            padding:28px;
            position:relative;
            overflow:hidden;
        }
        .main::before{
            content:"";
            position:absolute;
            inset:-60px;
            background:
                    radial-gradient(circle at 20% 20%, rgba(167,139,250,0.28), transparent 60%),
                    radial-gradient(circle at 85% 75%, rgba(109,40,217,0.22), transparent 62%);
            pointer-events:none;
        }
        .main-inner{ position:relative; }

        .top{
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:12px;
            flex-wrap:wrap;
        }

        .title{
            display:flex;
            flex-direction:column;
            gap:6px;
        }
        .title h1{
            margin:0;
            font-size:28px;
            font-weight:900;
        }
        .title p{
            margin:0;
            color:var(--muted);
            font-size:13px;
            line-height:1.6;
        }

        .badge{
            font-size:12px;
            padding:8px 12px;
            border-radius:999px;
            border:1px solid rgba(255,255,255,0.22);
            background:rgba(255,255,255,0.08);
            color:rgba(255,255,255,0.85);
            white-space:nowrap;
        }

        .section{
            margin-top:18px;
            border-radius:18px;
            border:1px solid rgba(255,255,255,0.18);
            background:rgba(255,255,255,0.07);
            padding:16px;
        }

        .section h2{
            margin:0 0 10px;
            font-size:16px;
            font-weight:900;
            letter-spacing:0.2px;
        }

        .faq{
            display:grid;
            gap:10px;
        }

        details{
            border-radius:14px;
            border:1px solid rgba(255,255,255,0.18);
            background:rgba(255,255,255,0.06);
            padding:12px 14px;
        }

        summary{
            cursor:pointer;
            font-weight:800;
            list-style:none;
        }
        summary::-webkit-details-marker{ display:none; }

        details p{
            margin:10px 0 0;
            color:var(--muted);
            font-size:13px;
            line-height:1.6;
        }

        /* RIGHT SIDE CARDS */
        .side{
            padding:18px;
        }

        .side h3{
            margin:0 0 12px;
            font-size:16px;
            font-weight:900;
        }

        .cards{
            display:grid;
            grid-template-columns: 1fr;
            gap:12px;
        }

        .card{
            border-radius:18px;
            border:1px solid rgba(255,255,255,0.18);
            background:rgba(255,255,255,0.07);
            padding:16px;
            position:relative;
            overflow:hidden;
        }
        .card::before{
            content:"";
            position:absolute;
            inset:-60px;
            background: radial-gradient(circle at 20% 20%, rgba(167,139,250,0.22), transparent 55%);
            pointer-events:none;
        }
        .card *{ position:relative; }

        .card b{
            display:block;
            font-size:14px;
            margin-bottom:6px;
        }

        .card p{
            margin:0;
            color:var(--muted);
            font-size:13px;
            line-height:1.55;
        }

        /* BUTTONS */
        .actions{
            margin-top:18px;
            display:flex;
            gap:12px;
            flex-wrap:wrap;
        }

        .btn{
            text-decoration:none;
            padding:12px 18px;
            border-radius:14px;
            font-weight:900;
            letter-spacing:0.2px;
            display:inline-flex;
            align-items:center;
            gap:8px;
            transition:all .2s ease;
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
            margin-top:18px;
            text-align:center;
            font-size:12px;
            color:rgba(255,255,255,0.65);
        }
    </style>
</head>

<body>
<div class="page">
    <div class="wrap">

        <!-- LEFT MAIN HELP -->
        <div class="glass main">
            <div class="main-inner">

                <div class="top">
                    <div class="title">
                        <h1>Help Center 📘</h1>
                        <p>Quick guide to use the Reservation & Billing System correctly.</p>
                    </div>
                    <div class="badge">Logged User: <b style="margin-left:6px;"><%= user %></b></div>
                </div>

                <div class="section">
                    <h2>Frequently Asked Questions</h2>

                    <div class="faq">
                        <details>
                            <summary>✅ How do I add a new reservation?</summary>
                            <p>
                                Go to Dashboard → “Add New Reservation”. Fill the form and click “Save Reservation”.
                                Customer ID and Customer Mobile must be unique.
                            </p>
                        </details>

                        <details>
                            <summary>🔍 How do I search reservation details?</summary>
                            <p>
                                Go to Dashboard → “Display Reservation Details” or “Search Reservation”. Enter the reservation number and search.
                            </p>
                        </details>

                        <details>
                            <summary>🧾 How do I print the bill?</summary>
                            <p>
                                Open “Calculate & Print Bill”, select the reservation number, add items/charges, then click “Print”.
                                You can also use “Print to Bill” from the reservations list.
                            </p>
                        </details>

                        <details>
                            <summary>⚠ What should I do if I get duplicate error?</summary>
                            <p>
                                Customer ID or Customer Mobile already exists in the system. Please use a different ID/mobile or update the existing reservation.
                            </p>
                        </details>
                    </div>
                </div>

                <div class="actions">
                    <a class="btn btn-primary" href="dashboard.jsp">⬅ Back to Dashboard</a>
                    <a class="btn btn-outline" href="index.jsp">🏠 Home</a>
                </div>

                <div class="footer">
                    © <%= java.time.Year.now() %> Ocean View Resort | Developed by Manuja Rathnayake
                </div>

            </div>
        </div>

        <!-- RIGHT SIDE GLASS CARDS -->
        <div class="glass side">
            <h3>Quick Tips ✨</h3>

            <div class="cards">
                <div class="card">
                    <b>📌 Reservation Rule</b>
                    <p>Always enter a unique Customer ID and Customer Mobile number to avoid duplicate errors.</p>
                </div>

                <div class="card">
                    <b>🗓 Date Checking</b>
                    <p>Check-Out date must be later than Check-In date. Always validate before saving.</p>
                </div>

                <div class="card">
                    <b>🧾 Billing Tip</b>
                    <p>Use “Print to Bill” from list reservations to directly generate the receipt quickly.</p>
                </div>

                <div class="card">
                    <b>🔐 Security</b>
                    <p>Always logout after usage to protect reservation and billing information.</p>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>