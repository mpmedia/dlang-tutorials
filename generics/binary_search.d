#! /usr/bin/env rdmd

import std.array;

/** D generics */

bool binarySearch(T)(T[] input,T value){
    while(!input.empty){
        auto i = input.length / 2;
        auto mid = input[i];
        if(mid>value) input = input[0..i];
        else if(mid<value) input = input[i+1..$];
        else return true;
    }
    return false;
}

void main(){
    assert(binarySearch([1,3,5,7,8,15],5));
    assert(!binarySearch([1,3,5,7,8,15],6));
}

unittest{
    assert(binarySearch([1,3,5,7,8,15],5));
    assert(!binarySearch([1,3,5,7,8,15],6));
}
    