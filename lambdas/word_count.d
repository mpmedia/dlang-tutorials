#! /usr/bin/env rdmd

import std.stdio, std.string, std.algorithm; 

/* count words from stdin */

/* compte le nombre d'occurences d'un mot à partir de l'entrée standard */

void main() { 
    
    uint[string] freqs; 
    
    foreach (line; stdin.byLine()) 
        foreach (word; split(strip(line)))  
            ++freqs[word.idup]; 
        
    // Print counts 
    string[] words = freqs.keys;
    //lambda
    sort!((a,b){return freqs[a] >  freqs[b];})(words);
    
    foreach (word; words) 
        writefln("%6u\t%s",freqs[word],word);
}