// package io.github.edufolly.flutterbluetoothserial;

// import android.content.Context;
// import android.content.Intent;

// import com.qhyjxm.intent.ActionBroadCast;
// import com.qhyjxm.main.ServerConfig;
// import com.qhyjxm.utility.BytesTool;
// import com.qhyjzs.tagencry.QHTagCoderInterface;
// import com.qhyjzs.tagencry.QhTagCoderException;

// import org.apache.log4j.Logger;

// public class EPC2Intent {

// public static void procEPC(byte[] epc, Context context) {
// if (epc == null)
// return;

// try {
// String livestockCode = null;

// if (ServerConfig.instance().decryptEnabled()) {
// livestockCode = coder.decry(epc);// 标签解码
// if (livestockCode == null) {
// livestockCode = BytesTool.bytes2hexStr(epc);
// if (!RedundantTagProc.instance().isRedundantCode(livestockCode)) {
// logger.error("recv invalid tag code");
// RedundantTagProc.instance().addCode(livestockCode);
// broadcastInvalidTagCode(context, livestockCode);
// }
// return;
// }
// } else
// livestockCode = BytesTool.bytes2hexStr(epc);

// if (RedundantTagProc.instance().isRedundantCode(livestockCode))
// return;

// broadcastTagCode(context, livestockCode);
// logger.info("Tag epc: " + livestockCode);
// } catch (QhTagCoderException e) {
// System.err.println(e.getMessage());
// }
// }

// private static void broadcastTagCode(Context context, String tagCode) {
// Intent intentMessage = new Intent();
// intentMessage.setAction(ActionBroadCast.TAG_CODE);
// intentMessage.putExtra(ActionBroadCast.CODE, tagCode.toUpperCase());
// context.sendBroadcast(intentMessage);
// }

// private static void broadcastInvalidTagCode(Context context, String tagCode)
// {
// Intent intentMessage = new Intent();
// intentMessage.setAction(ActionBroadCast.INVALID_TAG_CODE);
// intentMessage.putExtra(ActionBroadCast.CODE, tagCode.toUpperCase());
// context.sendBroadcast(intentMessage);
// }

// static QHTagCoderInterface coder = new QHTagCoderInterface();

// private static Logger logger = Logger.getLogger(EPC2Intent.class.getName());
// }
