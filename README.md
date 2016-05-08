# SwiftSample  
  
#### Swift + Alamofire + Realm を用いて天気予報API情報の取得、保存を行う  
  
##### 現在できていること  
- 天気予報はLivedoor Weather APIより取得 (OAuth認証不要)  
- Realmにより各都市の天気予報情報を1日ずつ取得  
  - データがなければinsert、あればupdate  
- 画面は2画面で都市選択画面と選択した都市の天気予報一覧画面  
 - 都市選択画面はMVCモデルで、天気予報一覧はMVVMモデルで作成 (してる途中)  
 - 天気予報API関連、RealmへでのI/Oは別モデルを作成
- ライブラリはCocoaPodsにて管理
 - 以下のライブラリを使用
   - Alamofire (通信ライブラリ)  
    - Realm (データベース)  
 
##### 今後やりたいこと
- RxSwiftによるReactive Programming (と中途半端なMVVMモデルを整理)
- SwiftyJsonによるパーサーの簡素化
