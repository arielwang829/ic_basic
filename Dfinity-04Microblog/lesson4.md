# Dfinity 作业4：

## 必填把 Message 类型改为一个记录结构，并在里面添加 time 字段，记录发消息的时间。

要求：

### 1）提交主程序源码并部署应用到主网提交 URL（2 分）

- **部署命令**

```
(base) $ dfx identity --network=ic set-wallet aqqot-qaaaa-aaaal-qaeba-cai
Setting wallet for identity 'default' on network 'ic' to id 'aqqot-qaaaa-aaaal-qaeba-cai'
Wallet set successfully.
(base) $ dfx identity --network=ic set-wallet --force aqqot-qaaaa-aaaal-qaeba-cai
Skipping verification of availability of the canister on the network due to --force...
Setting wallet for identity 'default' on network 'ic' to id 'aqqot-qaaaa-aaaal-qaeba-cai'
Wallet set successfully.
(base) $ dfx wallet --network=ic balance
10499677585440 cycles.
(base) $ dfx deploy --network=ic --with-cycles=300000000000
Deploying all canisters.
Creating canisters...
Creating canister "microblog"...
"microblog" canister created on network "ic" with canister id: "pqqhu-dqaaa-aaaal-qarta-cai"
Creating canister "microblog2"...
"microblog2" canister created on network "ic" with canister id: "pxrba-oiaaa-aaaal-qartq-cai"
Creating canister "microblog_assets"...
"microblog_assets" canister created on network "ic" with canister id: "o27fo-baaaa-aaaal-qarua-cai"
Building canisters...
Building frontend...
Installing canisters...
Installing code for canister microblog, with canister_id pqqhu-dqaaa-aaaal-qarta-cai
Installing code for canister microblog2, with canister_id pxrba-oiaaa-aaaal-qartq-cai
Installing code for canister microblog_assets, with canister_id o27fo-baaaa-aaaal-qarua-cai
Uploading assets to asset canister...
Starting batch.
Staging contents of new and changed assets:
  /favicon.ico 1/1 (15406 bytes)
  /index.html 1/1 (532 bytes)
  /index.html (gzip) 1/1 (345 bytes)
  /main.css (gzip) 1/1 (297 bytes)
  /index.js (gzip) 1/1 (83904 bytes)
  /index.js 1/1 (243120 bytes)
  /main.css 1/1 (537 bytes)
  /logo.png 1/1 (25397 bytes)
  /sample-asset.txt 1/1 (24 bytes)
  /index.js.LICENSE.txt (gzip) 1/1 (274 bytes)
  /index.js.map (gzip) 1/1 (149377 bytes)
  /index.js.LICENSE.txt 1/1 (413 bytes)
  /index.js.map 1/1 (655840 bytes)
Committing batch.
Deployed canisters.

```

- **URL**

https://pqqhu-dqaaa-aaaal-qarta-cai.ic0.app/

### 2）正确定义了新的 Message 的记录结构 （1 分）

[![2022-03-20-3-12-46.jpg](https://i.postimg.cc/wv7JGSRb/2022-03-20-3-12-46.jpg)](https://postimg.cc/MMJvc3Dy)

### 3）在 post 方法中，创建了新 Message 并记录了当前时间 （1 分）

[![2022-03-20-3-22-28.jpg](https://i.postimg.cc/BQ1LDT2H/2022-03-20-3-22-28.jpg)](https://postimg.cc/QHhdZW4d)


## 修改 posts 和 timeline 方法，仅返回指定时间之后的内容：

import Time "mo:base/Time";
func posts(since: Time.Time): async [Message] {…};
func timeline(since: Time.Time): async [Message] {…};

要求：

### 1）提交主程序源码并部署应用到主网提交 URL（2 分）

- **部署命令**

```
(base) $ dfx identity --network=ic set-wallet aqqot-qaaaa-aaaal-qaeba-cai
Setting wallet for identity 'default' on network 'ic' to id 'aqqot-qaaaa-aaaal-qaeba-cai'
Wallet set successfully.
(base) $ dfx identity --network=ic set-wallet --force aqqot-qaaaa-aaaal-qaeba-cai
Skipping verification of availability of the canister on the network due to --force...
Setting wallet for identity 'default' on network 'ic' to id 'aqqot-qaaaa-aaaal-qaeba-cai'
Wallet set successfully.
(base) $ dfx wallet --network=ic balance
10499677585440 cycles.
(base) $ dfx deploy --network=ic --with-cycles=300000000000
Deploying all canisters.
Creating canisters...
Creating canister "microblog"...
"microblog" canister created on network "ic" with canister id: "pqqhu-dqaaa-aaaal-qarta-cai"
Creating canister "microblog2"...
"microblog2" canister created on network "ic" with canister id: "pxrba-oiaaa-aaaal-qartq-cai"
Creating canister "microblog_assets"...
"microblog_assets" canister created on network "ic" with canister id: "o27fo-baaaa-aaaal-qarua-cai"
Building canisters...
Building frontend...
Installing canisters...
Installing code for canister microblog, with canister_id pqqhu-dqaaa-aaaal-qarta-cai
Installing code for canister microblog2, with canister_id pxrba-oiaaa-aaaal-qartq-cai
Installing code for canister microblog_assets, with canister_id o27fo-baaaa-aaaal-qarua-cai
Uploading assets to asset canister...
Starting batch.
Staging contents of new and changed assets:
  /favicon.ico 1/1 (15406 bytes)
  /index.html 1/1 (532 bytes)
  /index.html (gzip) 1/1 (345 bytes)
  /main.css (gzip) 1/1 (297 bytes)
  /index.js (gzip) 1/1 (83904 bytes)
  /index.js 1/1 (243120 bytes)
  /main.css 1/1 (537 bytes)
  /logo.png 1/1 (25397 bytes)
  /sample-asset.txt 1/1 (24 bytes)
  /index.js.LICENSE.txt (gzip) 1/1 (274 bytes)
  /index.js.map (gzip) 1/1 (149377 bytes)
  /index.js.LICENSE.txt 1/1 (413 bytes)
  /index.js.map 1/1 (655840 bytes)
Committing batch.
Deployed canisters.

```

- **URL**

https://pqqhu-dqaaa-aaaal-qarta-cai.ic0.app/

### 2）正确实现了按指定时间删选消息的功能 （2 分）

[![2022-03-20-3-11-21.jpg](https://i.postimg.cc/7YpPyjGT/2022-03-20-3-11-21.jpg)](https://postimg.cc/N5kv6Jxg)

## 7 思考题：如果关注对象很多，运行 timeline 就会比较慢，有什么办法可以提高效率？

要求：

### 1）用文字描述一个解决方案 （1分）

当前是串行方式一个接一个的获取每个followed发布的消息，改成并发方式，可以提升性能。

### 2）可行性评估（1分）

串行改并行提升执行效率。

## 附：完整代码

```js

import Text "mo:base/Text";
import List "mo:base/List";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Time "mo:base/Time";

actor {
    public type Message = {
        content: Text;
        time: Time.Time;
    };
    public type Microblog = actor {
        follow: shared(Principal) -> async (); //添加关注对象
        follows: shared query () -> async ([Principal]);//返回关注列表
        post: shared (Text) -> async (); //发布新消息
        posts: shared query () -> async [Message]; //返回所有发布的新消息
        timeline: shared () -> async [Message]; //返回所有关注对象发布的消息
    };
    stable var followed : List.List<Principal> = List.nil();

    public shared func follow(id: Principal) :async () {
        followed := List.push(id, followed);
    };
    public shared  query func follows() : async [Principal] {
        List.toArray(followed)
    };

    stable var messages : List.List<Message> = List.nil();

    public shared(msg) func post(content: Text) : async (){
        //assert(Principal.toText(msg.caller) == "t6nwz-iezgi-gv5pf-kbnt2-ghtpi-s44mm-mmvb3-6diem-iv7tp-p4jyz-bae");
        let message : Message = {
            content = Principal.toText(msg.caller);
            time = Time.now();
        };
        messages := List.push(message, messages);
    };
    public shared query func posts(since: Time.Time): async [Message] {
        var all:List.List<Message> = List.nil();
        for(msg in Iter.fromList(messages)) {
            if(msg.time > since) {
                all := List.push(msg, all);
            }
        };
        List.toArray(all);
    };
    public shared func timeline(since: Time.Time) : async [Message] {
        var all:List.List<Message> = List.nil();
        for(id in Iter.fromList(followed)) {
            let canister : Microblog = actor(Principal.toText(id));
            let msgs = await canister.posts();
            for(msg in Iter.fromArray(msgs)) {
               if(msg.time > since) {
                    all := List.push(msg, all);
                }; 
            }
        };
        List.toArray(all);
    };
};
    
```

