package io.github.edufolly.flutterbluetoothserial;

import com.unitrack.device.rfidreader.ws.handheld.data.cmdreply.KillTagReply;
import com.unitrack.device.rfidreader.ws.handheld.data.cmdreply.ReadTagContentReply;
import com.unitrack.device.rfidreader.ws.handheld.data.cmdreply.ReadVersionReply;
import com.unitrack.device.rfidreader.ws.handheld.data.cmdreply.ScanMaxRSSITagReply;
import com.unitrack.device.rfidreader.ws.handheld.data.cmdreply.ScanTagReply;
import com.unitrack.device.rfidreader.ws.handheld.data.cmdreply.SetupPortReplay;
import com.unitrack.device.rfidreader.ws.handheld.data.cmdreply.StopScanTagReply;
import com.unitrack.device.rfidreader.ws.handheld.data.cmdreply.TagMemAreaProcReply;
import com.unitrack.device.rfidreader.ws.handheld.data.cmdreply.WSCmdReplyVisitor;
import com.unitrack.device.rfidreader.ws.handheld.data.cmdreply.WriteTagContentReply;

public class WSCmdReplyProc extends WSCmdReplyVisitor {

	@Override
	public void visit(ReadVersionReply data) {
		// TODO Auto-generated method stub
	}

	@Override
	public void visit(SetupPortReplay data) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(ReadTagContentReply data) {
		// TODO Auto-generated method stub
	}

	@Override
	public void visit(WriteTagContentReply data) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(TagMemAreaProcReply data) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(KillTagReply data) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(ScanTagReply data) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(ScanMaxRSSITagReply data) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(StopScanTagReply data) {
		// TODO Auto-generated method stub

	}
}
