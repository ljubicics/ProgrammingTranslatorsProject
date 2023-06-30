// import section
import java_cup.runtime.Symbol;
import Parser.*;
%%
// declaration section
%class MPLexer
%function next_token
%line
%column
%debug
%type Symbol
%eofval{
return new Symbol(sym.EOF);
%eofval}


//states
%state COMMENT
//macros
slovo = [a-zA-Z]
cifra = [0-9]
%%


\/\/ { yybegin( COMMENT ); }
<COMMENT>~\n { yybegin( YYINITIAL ); }


[\t\n\r\s] { ; }
\( { return new Symbol( sym.otvorenazagrada); }
\) { return new Symbol( sym.zatvorenazagrada); }
\{ { return new Symbol( sym.otvorenaviticasta); }
\} { return new Symbol( sym.zatvorenaviticasta); }

//operators
\+ { return new Symbol( sym.plus); }
\* { return new Symbol( sym.puta); }
\- { return new Symbol( sym.minus); }
\/  { return new Symbol( sym.podeljeno); }
\< { return new Symbol( sym.manje); }
\> { return new Symbol( sym.vece); }
\<= { return new Symbol( sym.manjejednako); }
\>= { return new Symbol( sym.vecejednako); }



//separators
= { return new Symbol( sym.jednako); }
\<- { return new Symbol( sym.dodelatipa); }
:= { return new Symbol( sym.dodela); }
: { return new Symbol( sym.dvetacke); }

//key words

main {return new Symbol(sym.main);}
var {return new Symbol(sym.var); }
bool {return new Symbol(sym.bool); }
int {return new Symbol(sym.intidzer); }
float {return new Symbol(sym.plivajuci); }
scanf {return new Symbol(sym.scanf); }
printf {return new Symbol(sym.printf); }
while {return new Symbol(sym.dok); }
if {return new Symbol(sym.ifkrec); }
else {return new Symbol(sym.elsekrec); }
naredbe {return new Symbol(sym.naredbe); }
true  { return new Symbol( sym.konstanta); }
false { return new Symbol( sym.konstanta); }

//key words
{slovo}+ { return new Symbol(sym.id); }
//id-s
({slovo} | _)({slovo}|{cifra}| _ )* { return new Symbol(sym.id); }
//constants
{cifra}+ { return new Symbol( sym.konstanta); }
0\.{cifra}+(E[+\-]{cifra}+)? { return new Symbol( sym.konstanta);}

//error Symbol
. { if (yytext() != null && yytext().length() > 0) System.out.println( "ERROR: " + yytext() ); }