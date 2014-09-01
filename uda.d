#!dmd -run
/*
	User Defined Attributes used to decorate a function
	Inspired from vibe.d
*/
import std.stdio;

struct before{
	void function() dg;
}
struct after{
	void function() dg;
}

@before({writeln("DecoratedFunc is coming...");})
@before({writeln("DecoratedFunc is coming really fast...");}) 
@after({writeln("DecoratedFunc is done !");})
void DecoratedFunc()
{
	writeln("This is a Decorated Function");
}

void main(){
	import std.traits;

	//Using before UDA
	foreach(t ; __traits(getAttributes, DecoratedFunc)){
		if(is(typeof(t)==before))
			t.dg();
	}

	DecoratedFunc();

	//Using after UDA
	foreach(t ; __traits(getAttributes, DecoratedFunc)){
		if(is(typeof(t)==after))
			t.dg();
	}
}