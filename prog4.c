#include <stdio.h>
#include <string.h>
#include "y.tab.h"

extern int yyparse();
extern int yylex();
extern char* yytext;

int main(int argc, char* argv[])
{
	printf("%s \n", argv[0]);
	if(strcmp(argv[0], "./scanner") == 0)
	{
	        int currentToken = yylex();
	        printf("operating in scan mode\n\n");
		while(currentToken)
		{
		        switch(currentToken)
			{
			        case NAMETOKEN :
				  printf("Found NAMETOKEN %s\n", yytext);
				  break;
				case ROMANTOKEN :
				  printf("Found ROMANTOKEN token %s\n", yytext);
				  break;
				case NAME_INTITAL_TOKEN :
				  printf("Found NAME_INITIAL_TOKEN %s\n", yytext);
				  break;
				case SRTOKEN :
				  printf("Found SRTOKEN %s\n", yytext);
				  break;

				case JRTOKEN :
				  printf("Fount JRTOKEN %s\n", yytext);
				  break;

				case EOLTOKEN :
				  printf("Found EOLTOKEN %s\n", yytext);
				  break;

				case INTTOKEN :
				  printf("Found INTTOKEN %s\n", yytext);
				  break;

				case COMMATOKEN :
				  printf("Found COMMATOKEN %s\n", yytext);
				  break;

				case DASHTOKEN :
				  printf("Found DASHTOKEN %s\n", yytext);
				  break;

				case HASHTOKEN :
				  printf("Found HASHTOKEN %s\n", yytext);
				  break;

				case IDENTIFIERTOKEN :
				  printf("Found IDENTIFIERTOKEN %s\n", yytext);
				  break;

				default:
				  printf("Couldn't find the token\n");
			}
			currentToken = yylex();	
		}
	}
	else if(strcmp(argv[0], "./parser") == 0)
	  {
	    printf("Operating in parse mode\n\n");
	    if(yyparse() == 0)
	      {
		printf("Parse Successful!\n");
	      }
	  }

	return 0;
}
