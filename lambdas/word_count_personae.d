#!/usr/bin/env rdmd

import std.algorithm,std.conv,std.uni,std.regex,std.range,std.stdio,std.string;


/** count word frequency by character in Hamlet play */

struct PersonData{
    uint totalWordsSpoken;
    uint[string] wordCount; // a dictionary of uints with a string key
}

void addParagraph(string line,ref PersonData[string] info){
    //who's talking
    line = strip(line);
    auto sentence = std.algorithm.find(line,". ");
    if(sentence.empty){
        return;
    }
    auto persona = line[0..$-sentence.length];
    sentence=toLower(strip(sentence[2..$]));
    //get words
    auto words =split(sentence,regex("[ \t,.;:?]+"));
    // insert or update information
    if(!(persona in info)){
        info[persona]=PersonData();
    }
    info[persona].totalWordsSpoken+=words.length;
    foreach(word;words)++info[persona].wordCount[word];
}

void printResults(PersonData[string] info){
    
    foreach(persona,data;info){
        writefln("%20s %6u %6u",persona,data.totalWordsSpoken,data.wordCount.length);
    }
}

void main(){
    PersonData[string] info;
    //File info
    string currentParagraph;
    foreach(line;stdin.byLine()){
        if(line.startsWith("    ") 
            && line.length>4 
            && isAlpha(line[4])){
                //continuing a line
                currentParagraph ~=line[3..$];
        }else if(line.startsWith("  ") 
            && line.length> 2 
            && isAlpha(line[2])){
                // new persona started speaking
                addParagraph(currentParagraph,info);
                //convert char[] to string
                currentParagraph=to!string(line[2..$]);
        }
    }
    
    printResults(info);
}