<table class="pure-table join-table">
		<!--<td><div class='event'><span class="fa fa-map-marker fa-2x"></span></div></td>-->
		<td><div class='event'><span class="fa fa-bookmark fa-2x"></span></div></td>
		<td>
			<div class="meeting">
				<span class='purpose'><?php echo _("pass_label"); ?></span><br/>
				<span class='descr' style='font-size:90%;' >
					<p><?php echo _("join_link_text"); ?></p>
					<p id="team-pass"><?php echo Utilities::getHttpPath(); ?>/nexus.php?oid=<?php echo $_SESSION['orgUid']; ?></p>
				</span>
			</div>
		</td>
	</tr>
</table>