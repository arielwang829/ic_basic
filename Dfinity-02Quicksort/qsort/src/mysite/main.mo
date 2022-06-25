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