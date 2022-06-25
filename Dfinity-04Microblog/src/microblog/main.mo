import Text "mo:base/Text";
import List "mo:base/List";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Time "mo:base/Time";

actor {
    public type Message = {
        msg: Text;
        time: Time.Time;
    };

    public type Microblog = actor {
        follow: shared(Principal) -> async (); 
        follows: shared query () -> async [Principal];
        post: shared (Text) -> async ();
        posts: shared query (since: Time.Time) -> async [Message];
        timeline: shared (since: Time.Time) -> async [Message];
    };

    stable var followed : List.List<Principal> = List.nil();

    public shared func follow(id: Principal) : async () {
        followed := List.push(id, followed);
    };

    public shared query func follows() : async [Principal] {
        List.toArray(followed)
    };

    stable var messages : List.List<Message> = List.nil();

    public shared (msg) func post(text: Text) : async () {
        assert(Principal.toText(msg.caller) == "t6nwz-iezgi-gv5pf-kbnt2-ghtpi-s44mm-mmvb3-6diem-iv7tp-p4jyz-bae");
        let message: Message = {
            time = Time.now();
            msg = text;
        };
        messages := List.push<Message>(message, messages);
    };

    public shared query func posts(since: Time.Time) : async [Message] {

        let filterMessages = List.filter<Message>(messages, func(e){e.time >= since});
        List.toArray(filterMessages);
    };

    public shared func timeline(since: Time.Time) : async [Message] {
        var all : List.List<Message> = List.nil();

        for (id in Iter.fromList(followed)) {
            let canister : Microblog = actor(Principal.toText(id));
            let msgs = await canister.posts(since);
            for (msg in Iter.fromArray(msgs)) {
                all := List.push(msg, all);
            };
        };

        List.toArray(all);
    };
};
