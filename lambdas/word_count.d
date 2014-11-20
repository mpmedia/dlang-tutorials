#! /usr/bin/env rdmd

/* count words from stdin */

import std.stdio, std.string; 

/* compte le nombre d'occurences d'un mot à partir de l'entrée standard */

void main() { 
    
    uint[string] freqs; 
    
    foreach (line; stdin.byLine()) 
        foreach (word; split(strip(line)))  
            ++freqs[word.idup]; 
        
    // Print counts 
    
    foreach (key, value; freqs) {
        writefln("%6u\t%s",value,key);
    }
}