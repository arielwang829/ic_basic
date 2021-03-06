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