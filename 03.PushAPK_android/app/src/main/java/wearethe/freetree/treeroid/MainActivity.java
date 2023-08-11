package wearethe.freetree.treeroid; // 패키지 이름은 앱의 고유 식별자로 변경해야 합니다.

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
//import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.messaging.FirebaseMessaging;

public class MainActivity extends AppCompatActivity {

    TextView textView;
    TextView textView2;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.my_custom_layout);

        textView = findViewById(R.id.textView);
        textView2 = findViewById(R.id.textView2);

        // 등록 id 확인을 위한 리스터 설정하기 - 2021.08 변경
        FirebaseMessaging.getInstance().getToken()
                .addOnCompleteListener(new OnCompleteListener<String>() {

                    @Override
                    public void onComplete(@NonNull Task<String> task) {
                        if(!task.isSuccessful()){
                            Log.w("Main", "토큰 가져오는데 실패", task.getException());
                            return;
                        }

                        String newToken = task.getResult();
                        textView2.append("등록 id :" + newToken + "\n");
                        Log.d("Main - 등록 id :", newToken);
                    }
                });

        // 버튼 클릭시 - > 등록 id값 확인
        Button button = findViewById(R.id.button);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String instanceId = String.valueOf(FirebaseMessaging.getInstance().getToken());
                textView2.append("확인된 인스턴스 id : " + instanceId + "\n");
            }
        });
    }



    //--------------------------------------------------
    //--------------------------------------------------
    // 서비스로부터 인텐트를 받았을 때의 처리
    protected void onNewIntent(Intent intent) {
        textView2.append("onNewIntent 호출됨");
        if (intent != null) {
            processIntent(intent);
        }

        super.onNewIntent(intent);
    }

    private void processIntent(Intent intent) {
        String from = intent.getStringExtra("from");
        if (from == null) {
            textView2.append("from is null.");
            return;
        }

        String contents = intent.getStringExtra("contents");
        textView2.append("DATA : " + from + ", " + contents);
        textView.setText("[" + from + "]로부터 수신한 데이터2 : " + contents);
    }


}