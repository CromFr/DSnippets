#!dmd -run

import std.stdio;
import std.functional : toDelegate;

class Callback {

	void opCall(){
		foreach(ref dg ; m_dg){
			if(dg !is null)
				dg();
		}
	}

	size_t Add(void delegate() dg){
		m_dg[m_lastid++] = dg;
		return m_lastid-1;
	}

	size_t Add(void function() fun){
		return Add(toDelegate(fun));
	}

	void Remove(size_t id){
		m_dg[id].destroy();
	}

private:
	size_t m_lastid = 0;
	void delegate() m_dg[size_t];
}


void main(){
	auto cb = new Callback;
	cb.Add({writeln("Hello !");});
	auto id = cb.Add({writeln("My name is Thibault");});
	cb.Remove(id);
	cb.Add({writeln("My name is Thibaut");});

	cb();
}