<?

require_once("../control/bbb-api-php/includes/bbb-api.php"); 
     
$bbb = new BigBlueButton();
$hostname = "conference1.northbridgetech.org";
$resolved_ip = gethostbyname($hostname);
$status = "unknown";

function pingDomain($domain){
    $starttime = microtime(true);
    $file      = fsockopen ($domain, 80, $errno, $errstr, 10);
    $stoptime  = microtime(true);
    $status    = 0;

    if (!$file) $status = -1;  // Site is down
    else {
        fclose($file);
        $status = ($stoptime - $starttime) * 1000;
        $status = floor($status);
    }
    return $status;
}

  
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="style/style.css" type="text/css" />
    <script src="script/script.js" language="javascript"></script>
    <link rel="shortcut icon" href="image/northbridge-ico.png" />
    <title>Nexus | Health</title>	
  </head>
  
  <body>
    <div class="container">
      <div class="shell">
				<div class="projectsContent"> 

					<table cellpadding = "10">
						<tr><td>host</td><td>ip</td><td>port 80 response time</td></tr>
						<tr><td><? echo $hostname; ?></td><td><? echo gethostbyname($hostname); ?></td><td><? echo pingDomain($hostname); ?></td></tr>
					</table>
					Running meetings: <? echo print_r($bbb->getMeetingsWithXmlResponseArray());  ?>					
  				<!-- Show current server load: memory, cpu -->
  				<!-- Show test meeting room link for every meeting room -->
        
      	</div>
      </div><!--shell-->
    </div><!-- container -->         	
	</body>
	
</html>




