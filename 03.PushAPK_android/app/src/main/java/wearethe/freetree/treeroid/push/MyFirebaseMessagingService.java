package wearethe.freetree.treeroid.push;

import android.content.Context;
import android.content.Intent;
import android.util.Log;
import androidx.annotation.NonNull;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;
import wearethe.freetree.treeroid.MainActivity;

import java.util.Map;

public class MyFirebaseMessagingService extends FirebaseMessagingService {

    private static final String TAG = "FMS";

    @Override    // 뉴토큰
    public void onNewToken(@NonNull String token) {
        super.onNewToken(token);
        //token을 서버로 전송

        Log.d(TAG, "onNewToken 호출됨 : " + token);
    }

    @Override       // 메시지 리시버
    public void onMessageReceived(@NonNull RemoteMessage remoteMessage) {
        Log.d(TAG, "onMessageReceived 호출됨.");
        String from = remoteMessage.getFrom();
        Map<String, String> data = remoteMessage.getData();
        String contents = data.get("contents");
        Log.d(TAG, "from : " + from + ", contents : " + contents);
        sendToActivity(getApplicationContext(), from, contents);

        super.onMessageReceived(remoteMessage);
        //수신한 메시지를 처리
    }

    private void sendToActivity(Context context, String from, String contents) {
        Intent intent = new Intent(context, MainActivity.class);
        intent.putExtra("from", from);
        intent.putExtra("contents", contents);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_SINGLE_TOP | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        context.startActivity(intent);
    }
}