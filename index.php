<!DOCTYPE html>
<html>
	<head>
		<title>RainyDay | Finance for You</title>
		<link rel="stylesheet" type="text/css" href="styles/styles.css">

	</head>
	<body>
		<div id="top">
			
			<ul id="navigation">
				<li><a href="#index1" class="on">Info</a></li>
				<li><a href="#index2">Blog</a></li>
			</ul>
			<div id="app">
				<div id="logo">
					<h1 id="title">RainyDay</h1>
					<p>A NEW KIND OF FINANCE APP</p>
					
					
					<div class="projImgContainer">
				<div class="ar login_popup">
    				<a class="button" href="#" style="padding-top:1.5em;" >Login</a>        
    <div class="popup">
        
        <form>
            <P><span class="title">Username</span> <input name="" type="text" /></P>
            <P><span class="title">Password</span> <input name="" type="password" /></P>
            <P><input name="" type="button" value="Login" /></P>
        </form>
		<a href="#" class="close">CLOSE</a>
    </div>
</div>
			</div>
			
				</div>
			</div>
		</div>
		<div id="pageWrap">
			<div id = "leftPageWrap">
				<div class="section">
				
					<h1 id="headers" ><a name="index1">Info</a></h1>
					<div id="Team">	
						<table width="60%" align="center">
							<tr>
								<td width="20%"><img id="profiles" src="images/1.png" alt="Dashboard" /></td>
								<td width="20%"><img id="profiles" src="images/2.png" alt="Investments" /></td>
								<td width="20%"><img id="profiles" src="images/3.png" alt="Bonds" /></td>
								<td width="20%"><img id="profiles" src="images/4.png" alt="Pension" /></td>
								<td width="20%"><img id="profiles" src="images/5.png" alt="Predictive Model" /></td>
							</tr>
						</table>
						<h1 id="contact">Contact us at contact.rainyday@gmail.com</h1>	
			<p>Our Team: Alistair, Levi, Bhavin, Hemanth, Despoina, Stanislav.
			</p>
					</div>	
				</div>
				<div class="section">
					<h1 id="headers" ><a name="index2">Blog</a></h1>
					<?php
						include("blog_reader.php");
					?> 				
				</div>
				
				<div>
					<li><a href="blog_set.php" class="on">(new post)</a></li>	
				</div>
			</div>
			
			<div id = "twitterPageWrap">
	            <a class="twitter-timeline"  href="https://twitter.com/RainyDay_App" data-widget-id="716236889330728960">Tweets by @RainyDay_App</a>
		    	<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
			</div>
			
			<div id="footer"><h1>.</h1></div>
			
		</div>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
		<script>
			
			
			$(document).ready(function() {
    $(".button").click(function(e) {
        $("body").append(''); $(".popup").show(); 
        $(".close").click(function(e) { 
            $(".popup, .overlay").hide(); 
        }); 
    }); 
});
		
		var sql = require('sql.js');
		var db = new sql.Database('sql-lite/RainyDaySQLite.sqlite');
var stmt = db.prepare("SELECT * FROM expenses WHERE userID =:aval");//replace with usernames



var result = stmt.getAsObject({':aval' : 'user_24'});
console.log(result);//data into row

while (stmt.step()) console.log(stmt.get());//data into row
		
		
		
		
			</script>
	</body>
</html>