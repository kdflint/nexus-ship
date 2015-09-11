<?php

require_once("../core/domain/Util.php");

class MessageActivation {
	
	private $replyTo = "noreply@nexus.northbridgetech.org";
	private $bcc = "";
	private $subject = "[Nexus] Enrollment Confirmation";
	private $from = "Northbridge Technology Alliance <noreply@nexus.northbridgetech.org>";
	private $to = "";
	private $fname = "";
	private $username = "";
	private $allUsernames = "";
	private $groupName = "";
	private $orgId = "";
	private $multiples = "";	
	private $emailStyle = "";
	
	private $messageBody = 
	"Welcome " . $fname . "!\r\n\r\nYour enrollment is complete for username: " . $username . $multiples . "\r\n\r\nYou are now enabled to collaborate with " . $groupName . "\r\n\r\nYou can login to Nexus using this link.\r\n\r\n" . Util::getHttpPath() . "/login.php?oid=" . $orgid . "Enjoy,\r\n\r\nThe Development Team at\r\n\r\nNorthBridge Technology Alliance";
	
	public function __construct($email, $fname, $username, $allUsernames, $groupName, $orgid) {
		$this->to = $email;
		$this->fname = $fname;
		$this->username = $username;
		$this->allUsernames = $allUsernames;
		$this->groupName = $groupName;
		$this->orgId = $orgid;
	
		if (strlen($allUsernames) > 3) {
			$this->multiples = "\r\n\r\nNote: There are other usernames currently enrolled with this email address: " . Util::stripTrailingComma($allUsernames);
		}
	}
	
	private $links = array(
		// Global links text-to-html translation table
		// If a link in the text version of the message exactly matches a link here, it will translate into a styled button. Example:
		//"https://www.eventbrite.com/e/nexus-web-conference-training-tickets-16633180290" => "Reserve training seats"
	);

	private function formatLinks($in) {
		foreach($this->links as $key => $value) {
			$in = str_replace($key, "<a style='" . $this->emailStyle . "' href='" . $key . "'>" . $value . "</a>", $in);
		}
		return $in;
	}
	
	private function getMessageFooter() {
		return "Northbridge Technology Alliance creates software solutions for organizations who are engaged in social justice and community-building efforts. This message is produced and distributed by Northbridge Technology Alliance, a United States 501(c)(3) nonprofit corporation, Evanston, Illinois  60202";
	}
	
	/* generate these social media images from Front Awesome library at http://fa2png.io/ */
	private function constructHtmlMessage($boundary) {
		$formatLineBreaks = str_replace("\r\n\r\n", "</p><p>",$this->messageBody);
		$formatLineBreaks = str_replace("\r\n", "<br/>",$formatLineBreaks);
		$formatLinkButtons = $this->formatLinks($formatLineBreaks);
		return "--" . $boundary . "
Content-Type: text/html; charset=\"iso-8859-1\"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01//EN'>
<html>
	<head>
		<link rel='stylesheet' type='text/css' href='http://fonts.googleapis.com/css?family=Oxygen'>
	</head>
	<body style='font-family:Oxygen,Arial,sans-serif;color:#484848;'>
		<table style='width:90%;display:block;max-width:620px;'>
			<tr>
				<td colspan='2'><img src='" . Util::getHttpPath() . "/images/NB_horizontal_rgb.png' alt='Northbridge Technology Alliance Logo' width='252' height='68' style='padding-bottom:10px;padding-right:30px;'/></td>
			</tr>
			<tr>
				<td style='vertical-align:top;padding-top:10px;'>
					<a href='https://twitter.com/'" . Util::getTwitterHandle() . "' target='_blank'><img src='" . Util::getHttpPath() . "/images/twitter_dae0bc_32.png' width='32' height=32' /></a><br/>
					<a href='//plus.google.com/u/0/101145194341428988499?prsrc=3' rel='publisher' target='_blank' style='text-decoration:none;'><img src='" . Util::getHttpPath() . "/images/google-plus-square_dae0bc_32.png' width='32' height=32' /></a><br/>
					<a href='https://www.linkedin.com/company/2232384' target='_blank'><img src='" . Util::getHttpPath() . "/images/linkedin_dae0bc_32.png' width='32' height=32' /></a><br/>
					<a href='https://www.facebook.com/northbridgenfp#' target='_blank'><img src='" . Util::getHttpPath() . "/images/facebook-square_dae0bc_32.png' width='32' height=32' /></a><br/>
					<a href='https://github.com/NorthBridge/playbook/wiki/1.How-We-Do' target='_blank'><img src='" . Util::getHttpPath() . "/images/github_dae0bc_32.png' width='32' height=32' /></a>
				</td>
				<td style='vertical-align:top;padding-left:10px;'><p>" . $formatLinkButtons . "</p></td>
			</tr>
			<tr><td colspan='2'style='font-size:70%;color:#666666;'><hr color='#dae0bc'/><p>" . $this->getMessageFooter() . "</td></tr>
		</table>
	</body>
</html>
--" . $boundary . "--\r\n";
	}
	
	private function constructTextMessage($boundary) {
		return "--" . $boundary . "\r\n" . "Content-Type: text/plain; charset=\"iso-8859-1\"\r\n" . "Content-Transfer-Encoding: 7bit\r\n
" . $this->messageBody . "\r\n\r\n=================\r\n" . $this->getMessageFooter() . "\r\n";
	}
	
	private function constructMessage($boundary) {
		return $this->constructTextMessage($boundary) . $this->constructHtmlMessage($boundary);
	}
	
	public function send() {
		$boundary = uniqid('NTA');
		$headers = "From: " . $this->from . "\r\n";
		$headers .= "Bcc: " . $this->bcc . "\r\n";
		$headers .= "MIME-Version: 1.0\r\n";
		$headers .= "Content-Type: multipart/alternative; boundary=\"" . $boundary . "\"";
		mail($this->to, $this->subject, $this->constructMessage($boundary), $headers);
	}
	
	public function toString() {
		$output = "To = " . $this->to . "\r\n";
		$output .= "From = " . $this->from . "\r\n";
		$output .= "Reply To = " . $this->replyTo . "\r\n";
		$output .= "Bcc = " . $this->bcc . "\r\n";
		$output .= "Subject = " . $this->subject . "\r\n";
		$output .= "Path = " . Util::getHttpPath() . "\r\n";
		$output .= "Twitter = " . Util::getTwitterHandle() . "\r\n";
		$output .= "Message Body = " . $this->messageBody . "\r\n";
		return $output;
	}

}

?>