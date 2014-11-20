#!/usr/bin/env rdmd

import std.stdio, std.string,std.algorithm;

// break stdin into words
// add each word to the dictionary
void main(){
    ulong[string] dictionary;
    foreach(line;stdin.byLine()){
        foreach(word;splitter(strip(line))){
            if(word in dictionary)continue; //next word
            auto newID=dictionary.length;
            dictionary[word.idup]=newID;
            writeln(newID,'\t',word);
        }
    }
}