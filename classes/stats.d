#!/usr/bin/env rdmd

import std.exception,std.stdio;

/*
    FR : un outil qui execute des fonctions statistiques sur stdin
    EN :
        Usage
        
            echo 1 2 3 | ./stats.d Min Max
            
*/

interface Stat{
    void accumulate(double x);
    void postprocess();
    double result();
}

/* abstract class */
class IncrementalStat : Stat{
    protected double _result;
    abstract void accumulate(double x);
    void postprocess(){}
    double result(){
        return _result;
    }
}

/* EN : min of a serie of numbers */
class Min : IncrementalStat{
    //constructor
    this(){
        //double.max is the greatest double number 
        _result = double.max;
    }
    override void accumulate(double x){
        if(x<_result){
            _result = x;
        }
    }
}

class Max: IncrementalStat{
    // double.min_normal is the lowest double number
    this(){
        _result=double.min_normal;
    }
    
    override void accumulate(double x){
        if(x>_result) _result = x;
    }
}

class Average:IncrementalStat{
    private uint items=0;
    this(){
        _result=0;
    }
    override void accumulate(double x){
        _result+=x;
        items+=1;
    }
    override void postprocess(){
        if(items){
            _result/=items;
        }
    }
}

void main(string[] args){
    Stat[] stats;
    foreach(arg;args[1 .. $]){
        auto newStat = cast(Stat) Object.factory("stats."~arg);
        enforce(newStat,"Invalid statistics function: " ~ arg);
        stats ~= newStat;
    }
    //read each number from stdin
    for(double x;readf(" %s ",&x) == 1;){
        foreach(s;stats){
            s.accumulate(x);
        }
    }
    foreach(s;stats){
        s.postprocess();
        writeln(s.result());
    }
}