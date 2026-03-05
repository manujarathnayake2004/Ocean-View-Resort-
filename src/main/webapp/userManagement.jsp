<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String loggedUser = (String) session.getAttribute("loggedUser");
    String loggedRole = (String) session.getAttribute("loggedRole");

    if (loggedUser == null) { response.sendRedirect("login.jsp"); return; }
    if (loggedRole != null && !"ADMIN".equalsIgnoreCase(loggedRole)) {
        response.sendRedirect("accessDenied.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>User Management | Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <style>
        :root{
            --p1:#6D28D9; --p2:#A78BFA;
            --text: rgba(255,255,255,0.92);
            --muted: rgba(255,255,255,0.72);
            --glass: rgba(255,255,255,0.12);
            --glass2: rgba(255,255,255,0.08);
            --border: rgba(255,255,255,0.22);
            --shadow: 0 18px 70px rgba(0,0,0,0.55);
        }
        *{box-sizing:border-box;}
        body{
            margin:0;
            font-family:"Segoe UI", Arial, sans-serif;
            min-height:100vh;
            color:var(--text);
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
            padding: 22px 16px;
        }
        .glass{
            width:min(1000px,100%);
            background: linear-gradient(180deg, var(--glass), var(--glass2));
            border:1px solid var(--border);
            border-radius:26px;
            box-shadow:var(--shadow);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            padding: 22px;
        }
        .top{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap: 12px;
            margin-bottom: 10px;
        }
        .back{
            text-decoration:none;
            color:var(--text);
            padding:10px 12px;
            border-radius:14px;
            border:1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.08);
        }
        .back:hover{background:rgba(255,255,255,0.12);}
        h1{margin: 10px 0 6px; font-size: 34px;}
        p{margin:0 0 14px; color:var(--muted); font-size:13px; line-height:1.6;}

        .grid{
            display:grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }
        @media(max-width: 860px){ .grid{grid-template-columns:1fr;} }

        .card{
            border-radius: 22px;
            border: 1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.06);
            padding: 16px;
        }
        .card b{display:block; margin-bottom: 8px;}
        label{display:block; font-size:12px; color:var(--muted); margin:10px 0 6px;}
        input, select{
            width:100%;
            padding: 12px 12px;
            border-radius: 14px;
            border:1px solid rgba(255,255,255,0.18);
            background: rgba(0,0,0,0.18);
            color: var(--text);
            outline:none;
        }
        .btn{
            margin-top: 12px;
            width:100%;
            padding: 12px 14px;
            border-radius: 14px;
            border:1px solid rgba(255,255,255,0.18);
            background: linear-gradient(135deg, var(--p1), var(--p2));
            color:white;
            font-weight: 900;
            letter-spacing: 0.3px;
            cursor:pointer;
        }
        .btn:hover{filter: brightness(1.06);}

        table{
            width:100%;
            border-collapse: collapse;
            font-size: 13px;
        }
        th, td{
            padding: 10px 10px;
            border-bottom: 1px solid rgba(255,255,255,0.12);
            text-align:left;
            color: rgba(255,255,255,0.88);
        }
        th{color: rgba(255,255,255,0.70); font-weight: 800;}
        .tag{
            display:inline-block;
            padding: 6px 10px;
            border-radius: 999px;
            border: 1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.08);
            font-size: 12px;
        }
        .footer{
            text-align:center;
            margin-top: 14px;
            font-size: 12px;
            color: rgba(255,255,255,0.60);
        }
        .hint{
            font-size: 12px;
            color: rgba(255,255,255,0.65);
            margin-top: 8px;
        }
    </style>
</head>

<body>
<div class="page">
    <div class="glass">
        <div class="top">
            <a class="back" href="dashboard.jsp">← Back</a>
            <div style="font-size:12px;color:rgba(255,255,255,0.70);">
                Logged in: <b><%= loggedUser %></b> (ADMIN)
            </div>
        </div>

        <h1>User Management</h1>
        <p>Create new user accounts and manage roles. </p>


        <div class="grid">
            <!-- Create User -->
            <div class="card">
                <b>➕ Create New User</b>

                <!-- Change action later to your servlet (ex: CreateUserServlet) -->
                <form action="#" method="post">
                    <label>Username</label>
                    <input type="text" name="username" placeholder="ex: reception2" required />

                    <label>Password</label>
                    <input type="password" name="password" placeholder="Enter password" required />

                    <label>Role</label>
                    <select name="role" required>
                        <option value="ADMIN">ADMIN</option>
                        <option value="RECEPTIONIST">RECEPTIONIST</option>
                        <option value="MANAGER">MANAGER</option>
                    </select>

                    <label>Status</label>
                    <select name="status" required>
                        <option value="ACTIVE">ACTIVE</option>
                        <option value="DISABLED">DISABLED</option>
                    </select>

                    <button class="btn" type="submit">Create User</button>
                </form>

                <div class="hint">
                    Tip: later connect this form to a servlet that does INSERT into <b>users</b> table.
                </div>
            </div>

            <!-- Users List (UI sample) -->
            <div class="card">
                <b>👥 Existing Users (Sample View)</b>

                <!-- Later: load real users from DB using DAO -->
                <table>
                    <thead>
                    <tr>
                        <th>Username</th>
                        <th>Role</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>admin</td>
                        <td><span class="tag">ADMIN</span></td>
                        <td><span class="tag">ACTIVE</span></td>
                    </tr>
                    <tr>
                        <td>reception1</td>
                        <td><span class="tag">RECEPTIONIST</span></td>
                        <td><span class="tag">ACTIVE</span></td>
                    </tr>
                    <tr>
                        <td>manager1</td>
                        <td><span class="tag">MANAGER</span></td>
                        <td><span class="tag">ACTIVE</span></td>
                    </tr>
                    </tbody>
                </table>

                <div class="hint">
                    Next step: display real data using <b>UserDAO.getAllUsers()</b>.
                </div>
            </div>
        </div>

        <div class="footer">© <%= java.time.Year.now() %> Ocean View Resort • User Management</div>
    </div>
</div>
</body>
</html>