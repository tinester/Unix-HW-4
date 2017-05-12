 //Zach Eagan
 //CS 3376.002

%{
#include "y.tab.h"
#define YYSTYPE char*
%}

%option noyywrap

%option nounput

%option noinput

LETTER [a-zA-Z]
ROMAN [IVX]+
INT [0-9]+

%%
\n {yylval.str =yytext; return EOLTOKEN;}

, {yylval.str =yytext; return COMMATOKEN;}

[\-] {yylval.str = yytext; return DASHTOKEN;}

# {yylval.str = yytext; return HASHTOKEN;}

{ROMAN} {yylval.str = yytext; return ROMANTOKEN;}

{INT} {yylval.str = yytext; return INTTOKEN;}

Sr. {yylval.str = yytext; return SRTOKEN;}

Jr. {yylval.str = yytext; return JRTOKEN;}

{LETTER}{LETTER}+ {yylval.str = yytext; return NAMETOKEN;}

{LETTER}|{LETTER}\. {yylval.str = yytext; return NAME_INTITAL_TOKEN;}

({LETTER}|[0-9])({LETTER}|[0-9])* {yylval.str = yytext; return IDENTIFIERTOKEN;}

. {/* do nothing for default action */}

%%
