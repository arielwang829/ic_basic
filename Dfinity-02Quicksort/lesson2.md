## Dfinity 作业2：

用 motoko 实现一个快排函数：

```
quicksort : [var Int] -> ()
```

要求：
1）上传一个 motoko 源代码，里面实现了 quicksort 函数，并且这个代码是可以在 moc 里面运行的。（可以放代码链接，5 分）
2）上传一个 motoko 源代码，里面实现了一个 actor，它的公共接口是 qsort 。（可以放代码链接，3 分）
3）部署第2提的答案到主网之后的 Canister ID。（2 分）

步骤：

### 1.用 moc 调试运行

- **实现`quicksort`方法**

```js
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";

func quicksort(arr: [var Int]) {
    quicksortimpl(arr, 0, arr.size()-1)
};

func quicksortimpl(arr: [var Int], begin: Nat, end: Nat) {
    if (begin < end) {
        var key = arr[begin];
        var i = begin;
        var j = end;
        while (i < j) {
            while (i < j and arr[j] > key) {
                j-=1;
            };

            if (i < j) {
                arr[i] := arr[j];
                i+=1;
            };

            while (i < j and arr[i] < key) {
                i+=1;
            };

            if (i < j) {
                arr[j] := arr[i];
                j-=1;
            };
        };

        arr[i] := key;
        quicksortimpl(arr, begin, i - 1);
        quicksortimpl(arr, i + 1, end);
    }
};

var arr: [var Int] = [var 5, 9, 1, -19, 5, -8, 3, 21, 7, 6, 1];
quicksort(arr);
Debug.print(debug_show(arr));
```

- **`moc`调试**

```bash
[(base) Aos-MacBook-Air:mysite aowang$ moc --package base $(dfx cache show)/base -r src/mysite/main.mo 
[var -19, -8, +1, +1, +3, +5, +5, +6, +7, +9, +21]
```

### 2.把函数封装在一个 canister 里面，要求提供以下接口

```
public func qsort(arr: [Int]): async [Int]
```

- **实现qsort方法**

```js
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Array "mo:base/Array";

actor {
    func quicksort(arr: [var Int]) {
        quicksortimpl(arr, 0, arr.size()-1)
    };

    func quicksortimpl(arr: [var Int], begin: Nat, end: Nat) {
        if (begin < end) {
            var key = arr[begin];
            var i = begin;
            var j = end;
            while (i < j) {
                while (i < j and arr[j] > key) {
                    j-=1;
                };

                if (i < j) {
                    arr[i] := arr[j];
                    i+=1;
                };

                while (i < j and arr[i] < key) {
                    i+=1;
                };

                if (i < j) {
                    arr[j] := arr[i];
                    j-=1;
                };
            };

            arr[i] := key;
            quicksortimpl(arr, begin, i - 1);
            quicksortimpl(arr, i + 1, end);
        }
    };

    public func qsort(arr: [Int]): async [Int] {
        var arr2: [var Int] = Array.thaw(arr);
        quicksort(arr2);
        Array.freeze(arr2)
    };
}
```

- **本地部署**

```bash
[(base) Aos-MacBook-Air:mysite aowang$ dfx deploy
Creating a wallet canister on the local network.
The wallet canister on the "local" network for user "default" is "rwlgt-iiaaa-aaaaa-aaaaa-cai"
Deploying all canisters.
Creating canisters...
Creating canister "qsort"...
"qsort" canister created with canister id: "rrkah-fqaaa-aaaaa-aaaaq-cai"
Creating canister "qsort_assets"...
"qsort_assets" canister created with canister id: "ryjl3-tyaaa-aaaaa-aaaba-cai"
Building canisters...
Building frontend...
Installing canisters...
Creating UI canister on the local network.
The UI canister on the "local" network is "r7inp-6aaaa-aaaaa-aaabq-cai"
Installing code for canister qsort, with canister_id rrkah-fqaaa-aaaaa-aaaaq-cai
Installing code for canister qsort_assets, with canister_id ryjl3-tyaaa-aaaaa-aaaba-cai
Authorizing our identity (default) to the asset canister...
Uploading assets to asset canister...
Starting batch.
Staging contents of new and changed assets:
  /main.css 1/1 (537 bytes)
  /main.css (gzip) 1/1 (297 bytes)
  /favicon.ico 1/1 (15406 bytes)
  /index.html 1/1 (663 bytes)
  /index.html (gzip) 1/1 (382 bytes)
  /index.js.map 1/1 (653349 bytes)
  /index.js.map (gzip) 1/1 (148915 bytes)
  /index.js 1/1 (603973 bytes)
  /index.js (gzip) 1/1 (144664 bytes)
  /sample-asset.txt 1/1 (24 bytes)
  /logo.png 1/1 (25397 bytes)
Committing batch.
Deployed canisters.
```

- **本地调用**

```bash
$ dfx canister call qsort qsort '(vec{5;9;1;-19;5;-8;3;21;7;6;1})'
(
  vec { -19 : int; -8 : int; 1 : int; 1 : int; 3 : int; 5 : int; 5 : int; 6 : int; 7 : int; 9 : int; 21 : int;},
)
```

### 3.部署到主网

https://6xtoh-5yaaa-aaaal-qakaq-cai.ic0.app

- **命令行部署**

```bash
[(base) Aos-MacBook-Air:mysite aowang$ dfx deploy --network=ic --with-cycles=400000000000
Deploying all canisters.
Creating canisters...
Creating canister "mysite"...
"mysite" canister created on network "ic" with canister id: "6xtoh-5yaaa-aaaal-qakaq-cai"
Creating canister "mysite_assets"...
"mysite_assets" canister created on network "ic" with canister id: "66qf3-lqaaa-aaaal-qakba-cai"
Building canisters...
Building frontend...
Installing canisters...
Installing code for canister mysite, with canister_id 6xtoh-5yaaa-aaaal-qakaq-cai
Installing code for canister mysite_assets, with canister_id 66qf3-lqaaa-aaaal-qakba-cai
Uploading assets to asset canister...
Starting batch.
Staging contents of new and changed assets:
  /index.html 1/1 (529 bytes)
  /favicon.ico 1/1 (15406 bytes)
  /main.css 1/1 (537 bytes)
  /index.html (gzip) 1/1 (343 bytes)
  /main.css (gzip) 1/1 (297 bytes)
  /index.js 1/1 (242089 bytes)
  /index.js (gzip) 1/1 (83704 bytes)
  /logo.png 1/1 (25397 bytes)
  /sample-asset.txt 1/1 (24 bytes)
  /index.js.LICENSE.txt 1/1 (413 bytes)
  /index.js.LICENSE.txt (gzip) 1/1 (274 bytes)
  /index.js.map 1/1 (653747 bytes)
  /index.js.map (gzip) 1/1 (149009 bytes)
Committing batch.
Deployed canisters.
```

- **playground部署**

[![2022-02-28-1-57-21.jpg](https://i.postimg.cc/SKhmdZKF/2022-02-28-1-57-21.jpg)](https://postimg.cc/5XscNSvn)

```
[01:51:59] moc version 0.6.21
[01:51:59] base library version dfx-0.8.5-beta.0
[01:54:50] Compiling code...
[01:54:50] Compiled Wasm size: 167KB
[01:54:50] Deploying code...
[01:54:50] Requesting a new canister id...
[01:55:02] Got canister id 2tvx6-uqaaa-aaaab-qaclq-cai
[01:55:09] Code installed at canister id 2tvx6-uqaaa-aaaab-qaclq-cai
[02:15:07] Canister counter expired

```

### 4.使用主网的 Candid UI 调试运行

https://a4gq6-oaaaa-aaaab-qaa4q-cai.raw.ic0.app

https://a4gq6-oaaaa-aaaab-qaa4q-cai.raw.ic0.app/?id=475h5-dyaaa-aaaab-qac4a-cai

[![2022-02-28-2-51-15.jpg](https://i.postimg.cc/RZ8gx8Hy/2022-02-28-2-51-15.jpg)](https://postimg.cc/4Y66zWwQ)
