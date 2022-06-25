## 作业

### 06 支持消息的发布者名字

要求： 

#### 1）给 Message 增加 author 字段 （1 分） 

[![2022-03-20-11-50-50.jpg](https://i.postimg.cc/vTYcBzyB/2022-03-20-11-50-50.jpg)](https://postimg.cc/G8fcgvHw)


#### 2）增加 set_name 和 get_name 公共方法 （1 分）

```
public shared func set_name(name: Text) { … }; 

public shared func get_name() : async ?Text { … };
```

> 为了避免任何人都可以设置作者名，在`set_name`接口上添加了密码

[![2022-03-21-1-17-01.jpg](https://i.postimg.cc/YSNrWWbm/2022-03-21-1-17-01.jpg)](https://postimg.cc/3yRQMdMK)

### 07 实现课程中展示的 UI

并完成一下要求： 

#### 1）显示目前 follow 的作者列表 （2 分） 

- **microblog关注了microblog2**

```
$ dfx canister call microblog follow "(principal \"$(dfx canister id microblog2)\")"
$ dfx canister call microblog follows
(vec { principal "ryjl3-tyaaa-aaaaa-aaaba-cai" })
```


#### 2）在 timeline 中显示消息作者和时间 （2 分）

- 为microblog2构造些消息

```
dfx canister call microblog2 set_name '("arielwang", "yoyo")';
dfx canister call microblog2 post '("arielwang", "yoyo post 111")'
dfx canister call microblog2 post '("arielwang", "yoyo post 222")'
```


#### 主网部署

https://o27fo-baaaa-aaaal-qarua-cai.ic0.app/

#### 发帖测试

[![2022-03-21-1-23-00.jpg](https://i.postimg.cc/yx42XQx1/2022-03-21-1-23-00.jpg)](https://postimg.cc/vghPGv5k)

### 08 关注(follow)其它学员的 Canister

要求： 

#### 1）关注三个以上作者（2 分） 

```js
$ dfx canister --network=ic call pqqhu-dqaaa-aaaal-qarta-cai follow "(principal \"zorlp-byaaa-aaaal-qaskq-cai\")"
()

$ dfx canister --network=ic call pqqhu-dqaaa-aaaal-qarta-cai follow "(principal \"vksf3-6iaaa-aaaal-qamca-cai\")"
()

$ dfx canister --network=ic call pqqhu-dqaaa-aaaal-qarta-cai follow "(principal \"vksf3-6iaaa-aaaal-qamca-cai\")"
()

$ dfx canister --network=ic call pqqhu-dqaaa-aaaal-qarta-cai follows
(
  vec {
    principal "zorlp-byaaa-aaaal-qaskq-cai";
    principal "vksf3-6iaaa-aaaal-qamca-cai";
    principal "vksf3-6iaaa-aaaal-qamca-cai";
  },
)
```

[![2022-03-21-1-14-26.jpg](https://i.postimg.cc/B6DV6Tgd/2022-03-21-1-14-26.jpg)](https://postimg.cc/XGj81yt8)

#### 2）点击作者名字，会显示对方发布的消息列表 （2 分） 

**注意：**完成本题需要学员之间就 Message 的类型定义，以及 canister 公共方法的类型定义，达成一致意见。否则可能在远程调用时会遇到错误。



