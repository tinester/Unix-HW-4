%{
#include <stdio.h>
#include <string.h>
extern int yylex();
int yyerror(const char *s);
 %}


%error-verbose

%union {char* str;}

%start postal_addresses

%token <str>NAMETOKEN ROMANTOKEN NAME_INTITAL_TOKEN SRTOKEN JRTOKEN EOLTOKEN INTTOKEN COMMATOKEN DASHTOKEN HASHTOKEN IDENTIFIERTOKEN

%%

postal_addresses: address_block EOLTOKEN postal_addresses {/*printf("You successfully parsed a file\n");*/}
                  | address_block {/*printf("you are parsing an address\n");*/}
		  ;

address_block: name_part street_address location_part {/*printf("parsing an address...\n");*/
               fprintf(stderr, "\n");
}
               ;

name_part: personal_part last_name suffix_part EOLTOKEN {/*printf("parsing name-part...\n");*/}
	       | personal_part last_name EOLTOKEN {/*printf("parsing name-part...\n");*/}
           | error EOLTOKEN {printf("error on name part\n\n");}
	   ;

personal_part: NAMETOKEN {/*printf("parsed name (%s)\n", $1);*/
                         fprintf(stderr, "<FirstName>%s</FirstName>\n", $1);
                         }
	   | NAME_INTITAL_TOKEN {/*printf("parsed initial (%s)\n", $1);*/
	     fprintf(stderr, "<FirstName>%s</FirstName>\n", $1);
           }
	   ;

last_name: NAMETOKEN {/*printf("parsed last name (%s)\n", $1);*/
                     fprintf(stderr, "<LastName>%s</LastName>\n", $1);
                     }
	;

suffix_part: SRTOKEN {/*printf("parsed suffix (%s)\n", $1);*/
                     fprintf(stderr, "<Suffix>%s</Suffix>\n", $1);
                     }
        | JRTOKEN {/*printf("parsed suffix(%s)\n", $1);*/
	  fprintf(stderr, "<Suffix>%s</Suffix>\n", $1);
          }
        | ROMANTOKEN {/*printf("parsed suffix (%s)\n", $1);*/
	  fprintf(stderr, "<Suffix>%s</Suffix>\n", $1);
          }
	;

street_address: street_number street_name INTTOKEN EOLTOKEN {
        char *tmp = $3;
	tmp[strcspn(tmp, "\n")] = 0;
	/*printf("parsing street address... with %s at end\n", tmp);*/
	fprintf(stderr, "<AptNum>%s</AptNum>\n", tmp);
}
        | street_number street_name HASHTOKEN INTTOKEN EOLTOKEN {
	char *tmp = $4;
	tmp[strcspn(tmp, "\n")] = 0;
	/*printf("parsing street address with hash... with #%s at end\n",tmp );*/
	fprintf(stderr, "<AptNum>%s</AptNum>\n", tmp);
}
        | street_number street_name EOLTOKEN {/*printf("parsing street address no num at end...\n");*/}
	| error EOLTOKEN {printf("error on street address\n\n");}
        ;

street_number: INTTOKEN {/*printf("street num int (%s)\n", $1);*/
        fprintf(stderr, "<HouseNumber>%s</HouseNumber>\n", $1);
}
        | IDENTIFIERTOKEN {/*printf("street num is ident (%s)\n", $1);*/
	fprintf(stderr, "<HouseNumber>%s</HouseNumber>\n", $1);
}
	;

street_name: NAMETOKEN {/*printf("parsed street name (%s)\n", $1);*/
        fprintf(stderr, "<StreetName>%s</StreetName>\n", $1);
}
	;

location_part: town_name COMMATOKEN state_code zip_code EOLTOKEN {/*printf("parsing location...\n");*/}
        | error EOLTOKEN {printf("error on location part\n\n");}
	;

town_name: NAMETOKEN {/*printf("parsed town name (%s)\n", $1);*/
        fprintf(stderr, "<City>%s</City>\n", $1);
}
	;

state_code: NAMETOKEN {/*printf("parsed state (%s)\n", $1);*/
        fprintf(stderr, "<State>%s</State>\n", $1);
}
	;

zip_code: INTTOKEN DASHTOKEN INTTOKEN {/*printf("zip is parsed with dash (%s)\n", $1);*/
        fprintf(stderr, "<Zip>%s</Zip>\n", $1);
}
        | INTTOKEN {char *tmp = $1;
	tmp[strcspn(tmp, "\n")] = 0;
	/*printf("zip is parsed no dash (%s)\n", tmp);*/
	fprintf(stderr, "<Zip>%s</Zip>\n", $1);
}
	;
	       
	      
%%

int yyerror(const char *s)
{
  printf("%s\n", s);
  return 0;
}
