<table class="pure-table join-table">
		<!--<td><div class='event'><span class="fa fa-map-marker fa-2x"></span></div></td>-->
		<td><div class='event'><span class="fa fa-bookmark fa-2x"></span></div></td>
		<td>
			<div class="meeting">
				<span class='purpose'><?php echo _("One-Click Join"); ?></span><br/>
				<span class='descr' style='font-size:90%;' >
					<p><?php echo _("Seat holders can use this link to schedule and attend any meeting."); ?></p>
					<p><?php echo Utilities::getHttpPath(); ?>/nexus.php?oid=<?php echo $_SESSION['orgUid']; ?></p>
				</span>
			</div>
		</td>
	</tr>
</table>