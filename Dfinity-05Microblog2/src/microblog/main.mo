import List "mo:base/List";
import Iter "mo:base/Iter";
import Time "mo:base/Time";
import Principal "mo:base/Principal";
import Text "mo:base/Text";

actor {
    
    public type Message = {
        msg: Text;
        time: Time.Time;
        author: Text;
    };


    public type Microblog = actor {
        follow: shared(Principal) -> async ();
        follows: shared query() -> async [Principal];
        post: shared(Text) -> async ();
        posts: shared query() -> async [Message];
        //postsByTime: shared query(Time.Time) -> async [Message];
        timeline: shared () -> async [Message];
        //timelineByTime: shared (Time.Time) -> async [Message];
        set_name: shared (Text, Text) -> async ();
        get_name: shared () -> async ?Text;
    };
    
    stable var cname: Text = "noname";

    public shared func set_name(opt: Text, name: Text) {
        assert(opt== "arielwang");
        cname := name;
    };

    public shared func get_name() : async ?Text {
        return ?cname;
    };

    stable var followed: List.List<Principal> = List.nil();

    public shared func follow(id: Principal): async () {
        followed := List.push(id, followed);
    };

    stable var messages: List.List<Message> = List.nil();

    public shared query func follows(): async [Principal] {
        List.toArray(followed)
    };

    public shared (msg) func post(opt: Text, text: Text): async () {
        //assert(Principal.toText(msg.caller) == "sjjrp-53dak-iox3s-iip3u-phtq5-bm6ui-au3wo-j66to-lfnb7-lkhc2-oae");
        assert(opt == "arielwang");

        var now = Time.now();
        let message = {
            msg = text;
            time =  now;
            author = cname;
        };
        
        // messages := List.push(text, messages);
        messages := List.push(message, messages);

    };

    public shared query func posts(): async [Message] {
        List.toArray(messages)
    };

    public shared func timeline(): async [Message] {
        var all: List.List<Message> = List.nil();

        for (id in Iter.fromList(followed)) {
            // let canister: Microblog = actor(Principal.toText(id));
            // let msgs = await canister.posts();
            // for (msg in Iter.fromArray(msgs)) {
            //     all := List.push(msg, all);
            // };
            let userBlogs = await queryFollowsPosts(id);
            for (msg in Iter.fromArray(userBlogs)) {
                all := List.push(msg, all);
            };
        };

        List.toArray(all)
    };

    public shared func queryFollowsPosts(id: Principal): async [Message] {
        var all: List.List<Message> = List.nil();
        let canister: Microblog = actor(Principal.toText(id));
        let msgs = await canister.posts();
        for (msg in Iter.fromArray(msgs)) {
            all := List.push(msg, all);
        };

        List.toArray(all)
    }

    // public shared query func postsWithTime(since: Time.Time): async [Message] {
    //     var output : List.List<Message> = List.nil();
    //     for (msg in Iter.fromList(messages)) {
    //         if (msg.time >= since) {
    //             output := List.push(msg, output);
    //         };
    //     };

    //     List.toArray(output)
    // };

    // public shared func timelineWithTime(since: Time.Time): async [Message] {
    //     var all: List.List<Message> = List.nil();

    //     for (id in Iter.fromList(followed)) {
    //         let canister: Microblog = actor(Principal.toText(id));
    //         let msgs = await canister.postsWithTime(since);
    //         for (msg in Iter.fromArray(msgs)) {
    //             all := List.push(msg, all);
    //         };
    //     };

    //     List.toArray(all)
    // };
};