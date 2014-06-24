  <table>
  	<!--<tr><td colspan="2"><p><b><? echo($title); ?></b></p></td><td><p><b>Online?</b></p></td></td>-->
  
		<tr>
		<td valign="top">
		<a id="imageDivLink1" href="javascript:toggle('contentDivImg1', 'imageDivLink1');"><img style="margin:5px;" src="images/plus.png" height="15" width="15" /></a>
		</td>
		<td valign="top" width="300">Barbara, 
		<div id="contentDivImg1" style="display:none;">
			<p class="indented" ><b>Message: </b>Can you jump into a chat room today?</p>
			<p class="indented" ><a href="#">Reply</a> | <a href="#">Invite to chat</a></p>
		</div>	</td>
		<td valign="top"><b>April 9</b></td>
		</tr>
		
 
		<tr>
		<td valign="top">
		<a id="imageDivLink2" href="javascript:toggle('contentDivImg2', 'imageDivLink2');"><img style="margin:5px;" src="images/minus.png" height="15" width="15" /></a>
		</td>
		<td valign="top" width="300">David
		<div id="contentDivImg2" style="display:block;">
			<p class="indented" ><b>Message: </b>Hi Ada! Do you know where we saved the checklist from the August 14 event? I can't find it on Jeff's laptop.</p>
			<p class="indented" ><a href="#" onClick="toggleDisplay2('reply')">Reply</a></p>
		</div>	</td>
		<td valign="top"><b>April 6</b></td>
		</tr>		
		
  </table>
  &nbsp;<br/>
	&nbsp;<br/>
  <div id="reply" style="display:none">
  <hr/>
	<form action="http://northbridgetech.org/apps/nexus/messageProcessor.php" method="post">
		<p><b>To:</b> David (Howard Street Connections)</p>
		<p><b>From:</b> <? echo($_SESSION['fname']); ?> (<? echo($_SESSION['affiliation']); ?>)</p>
		<p><b>Message:</b></p> 
		<textarea rows="4" cols="50">
		Type your message here...
	</textarea>
		<input type="submit" value="Send Your Message"/>
	</form>
	</div>