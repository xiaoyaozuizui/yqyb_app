package io.github.edufolly.flutterbluetoothserial;

import android.content.Context;

// import io.github.edufolly.flutterbluetoothserial.EPC2Intent;
import com.unitrack.device.rfidreader.ws.handheld.data.outputdata.TAG_EPC_Data;
import com.unitrack.device.rfidreader.ws.handheld.data.outputdata.WSOutputDataVisitor;

import android.util.Log;

public class WSOutputDataProc extends WSOutputDataVisitor {

	public WSOutputDataProc(Context context) {
		this.context = context;
	}

	@Override
	public void visit(TAG_EPC_Data data) {
		// TODO Auto-generated method stub
		// InfoDump.printHexString(data.EPC());
		byte[] epc = data.EPC();
		Log.d("FlutterBluePlugin", "222222222222222222");
		if (epc != null && epc.length == 12) {
			// EPC2Intent.procEPC(epc, context);
		}
	}

	private Context context;
}
