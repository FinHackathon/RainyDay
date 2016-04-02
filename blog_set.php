<html>
<head>
<Title>Blog Post</Title>
<style type="text/css">
    body { background-color: #fff; border-top: solid 10px #000;
        color: #333; font-size: .85em; margin: 20; padding: 20;
        font-family: "Segoe UI", Verdana, Helvetica, Sans-Serif;
    }
    h1, h2, h3,{ color: #000; margin-bottom: 0; padding-bottom: 0; }
    h1 { font-size: 2em; }
    h2 { font-size: 1.75em; }
    h3 { font-size: 1.0em; }
    h4 { font-size: 0.6em; }
    table { margin-top: 0.75em; }
    th { font-size: 1.2em; text-align: left; border: none; padding-left: 0; }
    td { padding: 0.25em 2em 0.25em 0em; border: 0 none; }
</style>
</head>
<body>
<h1>New Blog Post:</h1>
<p>Fill in title and text <strong>Submit</strong> to post.</p>
<form method="post" action="blog_set.php" enctype="multipart/form-data" >
      
    <div style="width: 100%; overflow: hidden;">
        <div style="width: 600px; float: left;">
            <p>
                <label for="name">
                Title:
                </label>
                <br />
                <input type="text" name="name" id="name"/></br>
            </p>
            
            <p>
                <label for="post">
                Post:
                </label>
                <br />
                <textarea rows="4" cols="40"  name="post" id="post">
                </textarea>
            </p>
        </div>
        <div style="margin-left: 220px; width:40%">
            <fieldset>
                <legend>login details</legend>
                <label>User:<br />
                <input type="text" name="user"/></label><br />
                <label>Pass:<br/>
                <input type="password" name="pass"/><label>
            </fieldset>   
        </div>
    </div>
      
      <input type="submit" name="submit" value="Submit" />
</form>
<?php
    // DB connection info
    //TODO: Update the values for $host, $user, $pwd, and $db
    //using the values you retrieved earlier from the Azure Portal.
    $host = "eu-cdbr-azure-north-d.cloudapp.net";
    $user = "b2b8e9980d855f";
    $pwd = "383506b2";
    $db = "acsm_c5e6372ee6eccec";
    // Connect to database.
    try {
        $conn = new PDO( "mysql:host=$host;dbname=$db", $user, $pwd);
        $conn->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
    }
    catch(Exception $e){
        echo "<h3>HELP1</h3>"; //TEMP
        die(var_dump($e));

    }
    
    //RETRIEVE USER/PASS info
    $sql_select = "SELECT * FROM blog_users";
    $stmt = $conn->query($sql_select);
    $registrants = $stmt->fetchAll();
    $user = "";
    $pass = "";
    $loggedIn = false;
    if(count($registrants) > 0 && !empty($_POST)) {
        foreach($registrants as $registrant) {
            if($registrant['user'] == $_POST['user']
                && $registrant['pass'] == $_POST['pass']){
                $loggedIn = true;
            }
        }
        echo "</table>";
    } else {
        echo "<h3>Awaiting post...</h3>";
    }
    // Insert registration info
    if(!empty($_POST) && $loggedIn) {
    try {
        $name = $_POST['name'];
        $post = $_POST['post'];
        $date = date("Y-m-d");
        // Insert data
        $sql_insert = "INSERT INTO blog_posts (name, post, date)
                   VALUES (?,?,?)";
        $stmt = $conn->prepare($sql_insert);
        $stmt->bindValue(1, $name);
        $stmt->bindValue(2, $post);
        $stmt->bindValue(3, $date);
        $stmt->execute();
    }
    catch(Exception $e) {
        echo "<h3>HELP2</h3>"; //TEMP
        die(var_dump($e));
    }
    echo "<h3>Posted!</h3>";
    }
    // Retrieve data
    $sql_select = "SELECT * FROM blog_posts";
    $stmt = $conn->query($sql_select);
    $registrants = $stmt->fetchAll();
    if(count($registrants) > 0) {
        /*echo "<h2>Blog Posts:</h2>";
        echo "<table>";
        echo "<tr><th>Title</th>";
        echo "<th>Post</th>";
        echo "<th>Date</th></tr>";
        foreach($registrants as $registrant) {
            echo "<tr><td>".$registrant['name']."</td>";
            echo "<td>".$registrant['post']."</td>";
            echo "<td>".$registrant['date']."</td></tr>";
        }
        echo "</table>";*/
        foreach($registrants as $registrant) {
            echo "<h2 style='text-align:center;'>".$registrant['name']."</h2>";
            echo "<h3 style='text-align:center;'>".$registrant['post']."</h3>";
            echo "<h4 style='text-align:center;'>".$registrant['date']."</h4>";
        }
    } else {
        echo "<h3>No current posts.</h3>";
    }
?>
</body>
</html>
